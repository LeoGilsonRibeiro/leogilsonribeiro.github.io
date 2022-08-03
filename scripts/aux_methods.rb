# frozen_string_literal: false

# Métodos auxiliares

# Adicionar metadados ao cabeçalho do arquivo markdown
def add_metadata(author, title, text, path)

  metadata = begin
               text.split("\n")[0].split(/;\h*/)
             rescue
               return text
             end

  publisher = metadata[0] || 'Desconhecido'
  date = metadata[1] || 'Sem data'
  annote = metadata[2] ? "annote: #{metadata[2]}" : ''
  if author == 'Fernando Rey Puente'
    publisher = 'lgr.com.br'
    date = '2022'
  end
  relative_path = path.gsub(BLOG_FOLDER, '')
                      .gsub(' ', '-')
  yml_view_url = "#{MKDOCS_REPO_URL}/commits/main/#{relative_path.gsub(".md", "")}".downcase
  yml_delimiter = '---'

  yml_header = [yml_delimiter,
                "title: #{title.inspect}",
                "author: #{author}",
                "date: #{date}",
                "publisher: #{publisher.inspect}",
                "view_url: #{yml_view_url}",
                annote,
                yml_delimiter].join("\n")

  "#{yml_header}\n\n#{text.lines[1..-1].join.strip}"
  # "#{yml_header}\n\n__#{author}__ &nbsp;&nbsp;&nbsp; :octicons-calendar-24: #{publication_date} &nbsp;&nbsp;&nbsp; :material-newspaper-variant-outline: #{publisher}  \n#{annote}  \n---\n\n#{text}"
end

# Método para eliminar caracteres ilegais em nomes de arquivos
def fix_filename(str)
  str.unicode_normalize(:nfd).gsub(/\p{Mn}/, '') # Remover acentos (normalizar decompondo e remover non-spacing marks)
     .gsub(/[\/?*:|"<>,.\\]/, '')                # Remover caracteres proibidos em nomes de arquivos
     .gsub(/  /, ' ')                            # Remover espaços duplos
     .gsub(/^(#|\s)+/, '')                       # Remover hash (#) e espaços antes
     .gsub(/^(\X{1,70}\b)/, '\1')                # Limitar tamanho do nome de arquivo a aprox. 70 caracteres
     .unicode_normalize(:nfc)                    # Normalizar para NFC
end

# Converter arquivos docx em markdown realizando backup do arquivo original
def docx_to_markdown(docx_dir, markdown_dir, markdown_archive, dry_run, print_paths)
  # Mover arquivos antigos para uma pasta nova

  new_md_archive_dir = "#{markdown_archive}/#{Time.now.strftime("%Y-%m-%d-%H-%M-%S")}"
  puts "Arquivos markdown pré-existentes serão movidos para: #{new_md_archive_dir}" if print_paths
  `mkdir -p #{new_md_archive_dir}` unless dry_run

  Dir["#{markdown_dir}/*"].each do |md_file|
    `mv "#{md_file}" "#{new_md_archive_dir}"` unless dry_run
    puts "Moved #{md_file} to #{new_md_archive_dir}" if print_paths
  end

  Dir["#{docx_dir}**/*.docx"].each do |docx_file|
    next if File.basename(docx_file).match(/^_/)

    basename = File.basename(docx_file, '.docx')
    markdown_file = "#{markdown_dir}/#{basename}.md"
    `pandoc "#{docx_file}" -t markdown -o "#{markdown_file}" --wrap=none` unless dry_run
    puts "!! Arquivo #{docx_file} convertido para #{markdown_file}" if print_paths
  end
end
