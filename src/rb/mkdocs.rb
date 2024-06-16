#!/usr/bin/env ruby
# frozen_string_literal: false
# Converte arquivos em docx em um site utilizando mkdocs

start_time = Time.now

# Logger
require 'logger'
require 'fileutils'

logger = Logger.new($stdout, progname: 'mkdocs', formatter: proc { |severity, time, progname, msg| "#{severity.rjust(7, ' ')} | #{time.strftime('%d-%m-%Y %H:%M')} | #{msg}\n" })
logger.level = Logger::DEBUG

# Load stuff
Dir["#{__dir__}/lib/**/*.rb"].sort.each do |helper|
  require_relative helper
  logger.debug "Loaded helper \"#{File.basename(helper, '.rb')}\""
end


def create_folder(folder)
  if File.exist?(folder)
    FileUtils.rm_rf(folder)
    logger.warn "Erasing \"#{folder}\" ..."
  end
  Dir.mkdir(folder)
end

# create_folder(DOCS_MARKDOWN)

# Primeira parte: docx → md
DOCX_SKIP = true
logger.warn 'Skipping conversion of docx into markdown' if DOCX_SKIP

unless DOCX_SKIP

  docx_to_markdown(DOCX_DIR, MARKDOWN_AUTO, DRY_RUN)

  logger.info "Finished converting #{Dir["#{MARKDOWN_AUTO}/**/*.md"].count} files from docx to markdown"
  logger.warn "#{Dir["#{DOCX_DIR}/**/*.docx"].count - Dir["#{MARKDOWN_AUTO}/**/*.md"].count} docx files skipped"
end

# Segunda parte: md split
logger.info "Processing markdown files at \"#{MARKDOWN_AUTO}\" ..."

Dir["#{MARKDOWN_AUTO}/*.md"].each_with_index do |volume_file, v| # Loop de arquivos markdown
  logger.debug "Processing volume #{v + 1} of #{Dir["#{MARKDOWN_AUTO}/*.md"].count} ..."

  text = File.read(volume_file, :encoding => 'UTF-8')
  next unless text =~ /^# / # Saltar texto/arquivo sem H1

  vol_title = text.unicode_normalize(:nfc).split("\n")[0].gsub(/(^# |\*)/, '')
# p vol_title

  if v.zero? # Apresentação
    author = AUTHOR1
    editor = AUTHOR1
    vol_title = text_to_title(vol_title)
    text_title = text_to_title(text.split(/^# /)[1].split(/\n/)[0].gsub(/(^# |\*)/, ''))
    text = text.lines[1..-1].join.strip
    vol_dir = "#{DOCS_MARKDOWN}/#{string_to_path(vol_title)}"
    vol_file = "#{vol_dir}/README.md"
    `mkdir -p "#{vol_dir}"` unless DRY_RUN
    unless DRY_RUN
      File.write(vol_file, add_metadata(author, editor, text_title, text, '', vol_file))
      logger.debug "Created volume file :: #{vol_file}"
    end
    NAV << "###{text_title}:\n###   contents:"
    NAV << "#####{path_to_slug(vol_file)}"
    next

  else # Demais volumes
    NAV << "###{text_to_title(vol_title)}:"
  end

  text = text.gsub(vol_title, '').strip
  vol_dir = "#{DOCS_MARKDOWN}/#{string_to_path(vol_title.gsub(/:.+/, ''))}"

  unless DRY_RUN
    `mkdir -p "#{vol_dir}"`
    logger.debug "Created volume folder :: #{vol_dir}"
  end

  # Partes (Volume > Partes)
  parts_text = text.split(/^# /).select { |t| !t.empty? && t =~ /[A-Za-z]/ }

  parts_text.each_with_index do |part_text, i|

    part_title = part_text.split("\n")[0].gsub(/(^# |\*)/, '').strip
    part_text = part_text.lines[1..-1].join

    if i.zero? && part_text !~ /^## /       # 1. Introdução H1 sem Capítulos (Padrão)
      part_dir = vol_dir                    # Por isso fica no diretório do volume
      part_file = "#{part_dir}/README.md"
      unless DRY_RUN
        File.write(part_file, add_metadata(AUTHOR1, AUTHOR1, 'Introdução', part_text.strip, vol_title, part_file))
        logger.debug "Created intro_file :: #{part_file}"
      end
      NAV << "####{text_to_title(vol_title)}: #{path_to_slug(part_file)}"
      next

    elsif i.zero? && part_text =~ /^## /    # 2. Introdução H1 com Capítulos (Solução adhoc)
      part_file = "#{vol_dir}/README.md"
      # logger.debug "Found H1 with chapters :: #{part_file}"
      intro_text = part_text.split(/^## /)[0]
      unless DRY_RUN
        File.write(part_file, add_metadata(AUTHOR1, AUTHOR1, part_title, intro_text, vol_title, part_file))
        logger.debug "Created intro_file :: #{part_file}"
      end
      NAV << "#####{path_to_slug(part_file)}"
      part_dir = "#{vol_dir}/00-Introducao"
      unless Dir.exist?(part_dir) || DRY_RUN
        `mkdir -p "#{part_dir}"`
        logger.debug "Created part_dir :: #{part_dir}"
      end
      NAV << '###Introdução:'
      part_text = part_text.gsub(intro_text, '')

    elsif i.positive? && part_text !~ /^## / # 3. Parte sem Capítulos (Exceções)
      part_dir = "#{vol_dir}/#{i.to_s.rjust(2, '0')}-#{string_to_path(part_title)}"
      part_file = "#{part_dir}/README.md"
      unless Dir.exist?(part_dir) || DRY_RUN
        `mkdir -p "#{part_dir}"`
        logger.debug "Created dir for #{part_title} :: #{part_dir}"
      end
      NAV << "### section: \"#{part_title.gsub(/: /, ' - ')}\"\n###   contents:"
      unless DRY_RUN
        File.write(part_file, add_metadata(AUTHOR2, AUTHOR1, part_title, part_text, vol_title, part_file))
        logger.debug "Created #{part_title} :: #{part_file}"
      end
      NAV << "######{path_to_slug(part_file)}"
      next

    elsif i.positive? && part_text =~ /^## / # 4. Parte com Capítulos (Padrão)
      part_dir = "#{vol_dir}/#{i.to_s.rjust(2, '0')}-#{string_to_path(part_title)}"
      unless Dir.exist?(part_dir) || DRY_RUN
        `mkdir -p "#{part_dir}"` unless Dir.exist?(part_dir) || DRY_RUN
        logger.debug "Created part_dir :: #{part_dir}"
      end
      NAV << "### section: \"#{part_title.gsub(/: /, ' - ')}\"\n###   contents:"

    else
      logger.warn "Unknown case :: #{part_text.lines[0]}"
    end

    # Capítulos (Volume > Partes > Capítulos)
    chapters = part_text.split(/^## /).select { |t| !t.empty? && t =~ /[A-Za-z]/ }
    chapters.each_with_index do |chapter_text, ii|

      chapter_title = text_to_title(chapter_text.split("\n")[0])
      chapter_file  = "#{part_dir}/#{ii.to_s.rjust(2, '0')}-#{string_to_path(chapter_title)}.md"
      chapter_text = chapter_text.lines[1..-1].join.strip

      unless DRY_RUN
        File.write(chapter_file, add_metadata(AUTHOR2, AUTHOR1, chapter_title, chapter_text, vol_title, chapter_file)) unless DRY_RUN
        logger.debug "Created chapter_file :: #{chapter_file}"
      end

      NAV << "######{path_to_slug(chapter_file)}"
    end # Capítulos
  end # Partes
end # Volumes
logger.info "Finished creating #{Dir["#{DOCS_MARKDOWN}/**/*.md"].count} markdown files."

logger.info "Copying assets from \"#{MARKDOWN_STABLE}\" ..."
Dir["#{MARKDOWN_STABLE}/*.md"].each do |page_file|
  FileUtils.cp(page_file, DOCS_MARKDOWN) unless DRY_RUN
  FileUtils.cp(Dir["#{MARKDOWN_STABLE}/CNAME"], DOCS_MARKDOWN) unless DRY_RUN
  logger.debug "Copied #{page_file} to #{DOCS_MARKDOWN}"
end
logger.info "Finished copying #{Dir["#{MARKDOWN_STABLE}/**/*.md"].count} assets to \"#{DOCS_MARKDOWN}\""

logger.info "Copying assets from \"#{IMG_FILES}\" ..."
Dir["#{IMG_FILES}/*"].each do |img_file|
  `mkdir -p "#{DOCS_IMG}"` unless Dir.exist?(DOCS_IMG) || DRY_RUN
  FileUtils.cp(img_file, DOCS_IMG) unless DRY_RUN
  logger.debug "Copied #{img_file} to #{DOCS_IMG}"
end
logger.info "Finished copying #{Dir["#{IMG_FILES}/**/*.md"].count} assets to \"#{DOCS_IMG}\""


logger.info 'Generating NAVigation data...'
final_NAV = []
final_NAV << %(NAV:
  - 'Textos reunidos de Leo Gilson Ribeiro':
    - 'Textos reunidos de Leo Gilson Ribeiro': README.md)
NAV.each do |n|
  final_NAV << n.gsub(/#/, '  ').sub(/^( +)/, '\1- ').to_s
end

# puts NAV
logger.info "Finished generating #{final_NAV.count} lines of NAVigation data"

logger.info 'Copying yml files data...'
Dir["#{YML_FILES}/*.yml"].each do |yml_file|
  counter_part_file = "#{BLOG_FOLDER}/#{File.basename(yml_file)}"
  unless DRY_RUN
    File.write(counter_part_file, File.read(yml_file) + final_NAV.join("\n"))
    logger.debug "Created #{counter_part_file}"
  end
end
logger.info "Finished transfering #{Dir["#{YML_FILES}/**/*.yml"].count} yml files"

logger.info 'Finished'

logger.info "Script took #{Time.now - start_time}s to complete."

logger.info "#{Dir["#{MARKDOWN_AUTO}/**/*.md"].count} docx files converted, #{Dir["#{DOCX_DIR}/**/*.docx"].count - Dir["#{MARKDOWN_AUTO}/**/*.md"].count} docx files skipped, #{Dir["#{DOCS_MARKDOWN}/**/*.md"].count} markdown files created, #{Dir["#{MARKDOWN_STABLE}/**/*.md"].count} assets copied, #{Dir["#{YML_FILES}/**/*.yml"].count} yml files transfered"


if DEPLOY
  logger.info 'DEPLOYing to GitHub Pages...'
  `cd #{BLOG_FOLDER} && git add . && git commit -m "DEPLOYed to GitHub Pages" && git push origin master`
  `cd #{BLOG_FOLDER} && mkdocs gh-DEPLOY`
  logger.info 'Finished DEPLOYing to GitHub Pages'
end

puts final_NAV
