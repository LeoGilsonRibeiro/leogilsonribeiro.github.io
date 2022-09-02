#!/usr/bin/env ruby
# frozen_string_literal: false

start_time = Time.now
test_mode = false
# Converte arquivos em docx em um site utilizando mkdocs

# Ruby static code analyzer & formatter configurations
# https://rubocop.github.io/rubocop/
# rubocop:disable Metrics/BlockLength
# rubocop:disable Style/CommentedKeyword
# rubocop:disable Metrics/AbcSize
# rubocop:disable Style/StringLiteralsInInterpolation
# rubocop:disable Metrics/MethodLength

require 'logger'
formatter = proc { |severity, time, progname, msg| "#{severity.rjust(7, ' ')} | #{time.strftime('%d-%m-%Y %H:%M')} | #{msg}\n" }
logger = Logger.new($stdout, progname: 'mkdocs', formatter: formatter)
logger.level = Logger::DEBUG
# logger.level = Logger::INFO

logger.warn 'Testing mode enabled!' if test_mode


# dry_run = true
# docx_skip = true
#
# dry_run = true
# docx_skip = false
#
dry_run = false
docx_skip = false

# dry_run = false
# docx_skip = true

logger.info "dry_run = #{dry_run}" if dry_run
logger.info "docx_skip = #{docx_skip}" if docx_skip

require 'fileutils'
logger.debug 'Loaded gem "fileutils"'
Dir["#{__dir__}/lib/**/*.rb"].sort.each do |helper|
  require_relative helper
  logger.debug "Loaded helper \"#{File.basename(helper, '.rb')}\""
end

# Variáveis globais
BLOG_FOLDER = '/Users/bcdav/Dropbox/Blog/LGR'.freeze
MKDOCS_REPO_URL = 'https://github.com/LeoGilsonRibeiro/leogilsonribeiro.github.io'.freeze
AUTHOR1 = 'Fernando Rey Puente'.freeze
AUTHOR2 = 'Leo Gilson Ribeiro'.freeze
WORK_TITLE = 'Textos Reunidos de Leo Gilson Ribeiro'.freeze

# Caminhos para os arquivos
src_files = "#{BLOG_FOLDER}/src"
docx_dir = "#{src_files}/docx"
markdown_auto = "#{src_files}/markdown/markdown_auto"
markdown_stable = "#{src_files}/markdown/markdown_stable"
img_files = "#{src_files}/img"
markdown_archive = "#{src_files}/markdown/markdown_archive"
yml_files = "#{src_files}/yml"
docs_markdown = "#{BLOG_FOLDER}/docs/markdown"
docs_img = "#{docs_markdown}/img"
nav = []

logger.info 'Starting script ...'

if File.exist?(docs_markdown)
  FileUtils.rm_rf(docs_markdown)
  logger.warn "Erasing \"#{docs_markdown}\" ..."
end
Dir.mkdir(docs_markdown)

logger.info "Initializing docs folder at \"#{docs_markdown}\" ..."

# Primeira parte: docx → md
if docx_skip
  logger.warn 'Skipping conversion of docx into markdown'
else
  logger.info 'Converting docx to markdown...'
  docx_to_markdown(docx_dir, markdown_auto, dry_run)
  logger.info "Finished converting #{Dir["#{markdown_auto}/**/*.md"].count} files from docx to markdown"
  logger.warn "#{Dir["#{docx_dir}/**/*.docx"].count - Dir["#{markdown_auto}/**/*.md"].count} docx files skipped"
end

# Segunda parte: md split
logger.info "Processing markdown files at \"#{markdown_auto}\" ..."

Dir["#{markdown_auto}/*.md"].each_with_index do |volume_file, v|
  logger.debug "Processing volume #{v + 1} of #{Dir["#{markdown_auto}/*.md"].count} ..."
  text = File.read(volume_file)
  next unless text =~ /^# / || v.positive?

  # current_status = v == 1 ? 'Revisão preliminar' : 'Transcrição'

  vol_title = text.split("\n")[0].gsub(/(^# |\*)/, '')

  if v.zero? # Apresentação
    author = AUTHOR1
    editor = AUTHOR1
    vol_title = text_to_title(vol_title)
    text_title = text_to_title(text.split(/^# /)[1].split(/\n/)[0].gsub(/(^# |\*)/, ''))
    text = text.lines[1..-1].join.strip
    vol_dir = "#{docs_markdown}/#{string_to_path(vol_title)}"
    vol_file = "#{vol_dir}/README.md"
    `mkdir -p "#{vol_dir}"` unless dry_run
    unless dry_run
      File.write(vol_file, add_metadata(author, editor, text_title, text, '', vol_file))
      logger.debug "Created volume file :: #{vol_file}"
    end
    nav << "###{text_title}:"
    nav << "####{text_title}: #{path_to_slug(vol_file)}"
    next

  else # Demais volumes
    nav << "###{text_to_title(vol_title)}:"
  end

  text = text.gsub(vol_title, '').strip
  vol_dir = "#{docs_markdown}/#{string_to_path(vol_title.gsub(/:.+/, ''))}"

  unless dry_run
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
      unless dry_run
        File.write(part_file, add_metadata(AUTHOR1, AUTHOR1, 'Introdução', part_text.strip, vol_title, part_file))
        logger.debug "Created intro_file :: #{part_file}"
      end
      nav << "####{text_to_title(vol_title)}: #{path_to_slug(part_file)}"
      next

    elsif i.zero? && part_text =~ /^## /    # 2. Introdução H1 com Capítulos (Solução adhoc)
      part_file = "#{vol_dir}/README.md"
      # logger.debug "Found H1 with chapters :: #{part_file}"
      intro_text = part_text.split(/^## /)[0]
      unless dry_run
        File.write(part_file, add_metadata(AUTHOR1, AUTHOR1, part_title, intro_text, vol_title, part_file))
        logger.debug "Created intro_file :: #{part_file}"
      end
      nav << "####{text_to_title(vol_title)}: #{path_to_slug(part_file)}"
      part_dir = "#{vol_dir}/00-Introducao"
      unless Dir.exist?(part_dir) || dry_run
        `mkdir -p "#{part_dir}"`
        logger.debug "Created part_dir :: #{part_dir}"
      end
      nav << '###Introdução:'
      part_text = part_text.gsub(intro_text, '')

    elsif i.positive? && part_text !~ /^## / # 3. Parte sem Capítulos (Exceções)
      part_dir = "#{vol_dir}/#{i.to_s.rjust(2, '0')}-#{string_to_path(part_title)}"
      part_file = "#{part_dir}/README.md"
      unless Dir.exist?(part_dir) || dry_run
        `mkdir -p "#{part_dir}"`
        logger.debug "Created dir for #{part_title} :: #{part_dir}"
      end
      nav << "####{part_title.gsub(/: /, ' - ')}:"
      unless dry_run
        File.write(part_file, add_metadata(AUTHOR2, AUTHOR1, part_title, part_text, vol_title, part_file))
        logger.debug "Created #{part_title} :: #{part_file}"
      end
      nav << "#####{part_title.gsub(/: /, ' - ')}: #{path_to_slug(part_file)}"
      next

    elsif i.positive? && part_text =~ /^## / # 4. Parte com Capítulos (Padrão)
      part_dir = "#{vol_dir}/#{i.to_s.rjust(2, '0')}-#{string_to_path(part_title)}"
      unless Dir.exist?(part_dir) || dry_run
        `mkdir -p "#{part_dir}"` unless Dir.exist?(part_dir) || dry_run
        logger.debug "Created part_dir :: #{part_dir}"
      end
      nav << "####{part_title.gsub(/: /, ' - ')}:"

    else
      logger.warn "Unknown case :: #{part_text.lines[0]}"
    end

    # Capítulos (Volume > Partes > Capítulos)
    chapters = part_text.split(/^## /).select { |t| !t.empty? && t =~ /[A-Za-z]/ }
    chapters.each_with_index do |chapter_text, ii|

      chapter_title = text_to_title(chapter_text.split("\n")[0])
      chapter_file  = "#{part_dir}/#{ii.to_s.rjust(2, '0')}-#{string_to_path(chapter_title)}.md"
      chapter_text = chapter_text.lines[1..-1].join.strip

      unless dry_run
        File.write(chapter_file, add_metadata(AUTHOR2, AUTHOR1, chapter_title, chapter_text, vol_title, chapter_file)) unless dry_run
        logger.debug "Created chapter_file :: #{chapter_file}"
      end

      nav << "#####{chapter_title.gsub(/: /, ' - ')}: #{path_to_slug(chapter_file)}"
    end # Capítulos
  end # Partes
end # Volumes
logger.info "Finished creating #{Dir["#{docs_markdown}/**/*.md"].count} markdown files."

logger.info "Copying assets from \"#{markdown_stable}\" ..."
Dir["#{markdown_stable}/*.md"].each do |page_file|
  FileUtils.cp(page_file, docs_markdown) unless dry_run
  logger.debug "Copied #{page_file} to #{docs_markdown}"
end
logger.info "Finished copying #{Dir["#{markdown_stable}/**/*.md"].count} assets to \"#{docs_markdown}\""

logger.info "Copying assets from \"#{img_files}\" ..."
Dir["#{img_files}/*"].each do |img_file|
  `mkdir -p "#{docs_img}"` unless Dir.exist?(docs_img) || dry_run
  FileUtils.cp(img_file, docs_img) unless dry_run
  logger.debug "Copied #{img_file} to #{docs_img}"
end
logger.info "Finished copying #{Dir["#{img_files}/**/*.md"].count} assets to \"#{docs_img}\""


logger.info 'Generating navigation data...'
final_nav = []
final_nav << %(nav:
  - 'Textos reunidos de Leo Gilson Ribeiro':
    - 'Textos reunidos de Leo Gilson Ribeiro': README.md)
nav.each do |n|
  final_nav << n.gsub(/#/, '  ').sub(/^( +)/, '\1- ').to_s
end
logger.info "Finished generating #{final_nav.count} lines of navigation data"

logger.info 'Copying yml files data...'
Dir["#{yml_files}/*.yml"].each do |yml_file|
  counter_part_file = "#{BLOG_FOLDER}/#{File.basename(yml_file)}"
  unless dry_run
    File.write(counter_part_file, File.read(yml_file) + final_nav.join("\n"))
    logger.debug "Created #{counter_part_file}"
  end
end
logger.info "Finished transfering #{Dir["#{yml_files}/**/*.yml"].count} yml files"

logger.info 'Finished'

logger.info "Script took #{Time.now - start_time}s to complete."

logger.info "#{Dir["#{markdown_auto}/**/*.md"].count} docx files converted, #{Dir["#{docx_dir}/**/*.docx"].count - Dir["#{markdown_auto}/**/*.md"].count} docx files skipped, #{Dir["#{docs_markdown}/**/*.md"].count} markdown files created, #{Dir["#{markdown_stable}/**/*.md"].count} assets copied, #{Dir["#{yml_files}/**/*.yml"].count} yml files transfered"
