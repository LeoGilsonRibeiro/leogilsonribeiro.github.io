#!/usr/bin/env ruby
# frozen_string_literal: false

# Converte arquivos em docx em um site utilizando mkdocs

# Ruby static code analyzer & formatter configurations
# https://rubocop.github.io/rubocop/
# rubocop:disable Metrics/BlockLength
# rubocop:disable Style/CommentedKeyword
# rubocop:disable Metrics/AbcSize
# rubocop:disable Style/StringLiteralsInInterpolation
# rubocop:disable Metrics/MethodLength

start_time = Time.now
require_relative 'aux_methods'
require_relative 'roman_numerals'
require 'fileutils'


# Variáveis globais
BLOG_FOLDER = '/Users/bcdav/Dropbox/Blog/LGR'.freeze
MKDOCS_REPO_URL = 'https://github.com/bcdavasconcelos/LGR'.freeze
AUTHOR1 = 'Fernando Rey Puente'.freeze
AUTHOR2 = 'Leo Gilson Ribeiro'.freeze

# Controle de fluxo
# dry_run = true
ignore_docx_conversion = true
do_not_print_paths = true

dry_run = false
# ignore_docx_conversion = false
# do_not_print_paths = false
dir_list = []
dir_hash = {}
chapter_files = []
nav = []

# Caminhos para os arquivos
src_files = "#{BLOG_FOLDER}/src"
docx_dir = "#{src_files}/docx"
markdown_volumes = "#{src_files}/markdown/markdown_volumes"
markdown_pages = "#{src_files}/markdown/markdown_pages"
markdown_archive = "#{src_files}/markdown//markdown_archive"
yml_files = "#{src_files}/yml"
docs_markdown = "#{BLOG_FOLDER}/docs/markdown"
# docs_markdown = "#{BLOG_FOLDER}/docs/markdown"
FileUtils.rm_rf(docs_markdown) if File.exist?(docs_markdown)
Dir.mkdir(docs_markdown)

# Primeira parte: docx → md
docx_to_markdown(docx_dir, markdown_volumes, markdown_archive, dry_run, do_not_print_paths) unless ignore_docx_conversion

# Segunda parte: md split
Dir["#{markdown_volumes}/*.md"].each_with_index do |volume_file, v|
    text = File.read(volume_file)
    next unless text =~ /^# / || v.positive?

    vol_title = v.zero? ? 'Textos Reunidos' : text.split("\n")[0]
    if v.zero? # Apresentação
      vol_title = 'Textos Reunidos'
      vol_dir = "#{docs_markdown}/#{string_to_path(vol_title)}"
      `mkdir -p "#{vol_dir}"` unless dry_run
      vol_file = "#{vol_dir}/README.md"
      File.write(vol_file, add_metadata(AUTHOR1, fix_doc_title(text.split("\n")[0]), text, vol_file)) unless dry_run
      nav << "##{fix_doc_title(vol_title)}:"
      nav << "###{fix_doc_title(text.split(/^# /)[0])}: #{path_to_slug(vol_file)}"
      next
    else # Demais volumes
      nav << "###{fix_doc_title(vol_title)}:"
    end

    text = text.gsub(vol_title, '').strip
    vol_dir = "#{docs_markdown}/#{string_to_path(vol_title.gsub(/:.+/, ''))}"
    `mkdir -p "#{(vol_dir)}"` unless dry_run
    puts "- #{vol_dir}" unless do_not_print_paths

  # Partes (Volume > Partes)
    parts_text = text.split(/^# /).reject(&:empty?)
    parts_text.each_with_index do |part_text, i|
      next unless part_text =~ /[A-Za-z]+/

      part_title = fix_doc_title(part_text.split("\n")[0])
      part_text = part_text.lines[1..-1].join

      if i.zero? && part_text !~ /^## /       # 1. Introdução H1 sem Capítulos (Padrão)
        part_dir = vol_dir                    # Por isso fica no diretório do volume
        chapter_files << part_file = "#{part_dir}/README.md"
        File.write(part_file, add_metadata(AUTHOR1, 'Introdução', part_text.strip, part_file)) unless dry_run
        puts "    - #{part_file}" unless do_not_print_paths
        nav << "####{fix_doc_title(vol_title)}: #{path_to_slug(part_file)}"
        next

      elsif i.zero? && part_text =~ /^## /    # 2. Introdução H1 com Capítulos (Solução adhoc)
        part_dir = vol_dir
        chapter_files << part_file = "#{part_dir}/README.md"
        intro_text = part_text.split(/^## /)[0]
        File.write(part_file, add_metadata(AUTHOR1, part_title, intro_text, part_file)) unless dry_run
        nav << "####{fix_doc_title(vol_title)}: #{path_to_slug(part_file)}"

        part_dir = "#{part_dir}/00-Introducao"
        `mkdir -p "#{part_dir}"` unless Dir.exist?(part_dir) || dry_run
        nav << '###Introdução:'

        part_text = part_text.gsub(intro_text, '')
        puts "    - #{part_dir}" unless do_not_print_paths

      elsif i.positive? && part_text !~ /^## / # 3. Parte sem Capítulos (Exceções)
        part_dir = "#{vol_dir}/#{i.to_s.rjust(2, '0')}-#{string_to_path(part_title)}"
        dir_list << [part_dir, part_title]
        dir_hash[part_dir] = part_title
        part_file = "#{part_dir}/README.md"
        `mkdir -p "#{part_dir}"` unless Dir.exist?(part_dir) || dry_run
        nav << "####{part_title.gsub(/: /, ' - ')}:"
        # puts "    - #{part_dir}" unless do_not_print_paths
        File.write(part_file, add_metadata(AUTHOR2, part_title, part_text, part_file)) unless dry_run
        nav << "#####{part_title.gsub(/: /, ' - ')}: #{path_to_slug(part_file)}"
        # puts "        - #{part_file}" unless do_not_print_paths
        next

      elsif i.positive? && part_text =~ /^## / # 4. Parte com Capítulos (Padrão)
        part_dir = "#{vol_dir}/#{i.to_s.rjust(2, '0')}-#{string_to_path(part_title)}"
        dir_list << [part_dir, part_title]
        dir_hash[part_dir] = part_title
        `mkdir -p "#{part_dir}"` unless Dir.exist?(part_dir) || dry_run
        nav << "####{part_title.gsub(/: /, ' - ')}:"
        # puts "    - #{part_dir}" unless do_not_print_paths
      else
        ''
      end

     # Capítulos (Volume > Partes > Capítulos)
      chapters = part_text.split(/^## /).reject(&:empty?)
      chapters.each_with_index do |chapter_text, ii|
        next if chapter_text !~ /[A-Za-z]+/

        chapter_title = fix_doc_title(chapter_text.split("\n")[0])
        chapter_file  = "#{part_dir}/#{ii.to_s.rjust(2, '0')}-#{string_to_path(chapter_title)}.md"
        chapter_text = chapter_text.lines[1..-1].join.strip

        `touch "#{chapter_file}"` unless dry_run
        File.write(chapter_file, add_metadata(AUTHOR2, chapter_title, chapter_text, chapter_file)) unless dry_run
        puts "        - #{chapter_file}" unless do_not_print_paths
        nav << "#####{chapter_title.gsub(/: /, ' - ')}: #{path_to_slug(chapter_file)}"
      end # Capítulos
    end # Partes
  end # Volumes

# Terceira parte:
Dir["#{markdown_pages}/*.md"].each do |page_file|
  FileUtils.cp(page_file, docs_markdown) unless dry_run
  puts "Moved #{page_file} to #{docs_markdown}" unless do_not_print_paths
end

# puts Clipboard.copy nav.join("\n")
# puts dir_hash.map! { |k, v| dir_hash[k] = [v, ] }.join("\n")
# puts nav.join("\n")

final_nav = []
final_nav << 'nav:'
nav.each do |n|
  final_nav << n.gsub(/#/, '  ').sub(/^( +)/, '\1- ').to_s
end

Dir["#{yml_files}/*.yml"].each do |yml_file|
  counter_part_file = "#{BLOG_FOLDER}/#{File.basename(yml_file)}"

  # FileUtils.cp_r(yml_file, counter_part_file) if File.exist?(counter_part_file) && !dry_run
  # puts "Moved #{yml_file} to #{BLOG_FOLDER}" unless do_not_print_paths
  File.write(counter_part_file, File.read(yml_file) + final_nav.join("\n")) unless dry_run
  # `echo "#{final_nav.join("\n")}" >> "#{counter_part_file}"` unless dry_run

end

puts "Script levou #{Time.now - start_time}s para concluir"
# puts "\n\n========== Pastas ==========\n\n"
# puts dir_list.uniq.sort.join("\n")
# puts "\n\n========== Arquivos ==========\n\n"
# puts chapter_files.uniq.sort.join("\n")
# puts "\n\n========== Combinado ==========\n\n"
# puts (dir_list + chapter_files).uniq.sort.join("\n")
