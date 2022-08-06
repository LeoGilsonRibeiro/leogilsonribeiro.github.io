# Adicionar metadados ao cabeçalho do arquivo markdown
def add_metadata(author, editor, title, text, vol_title, path) # rubocop:disable Metrics/AbcSize

  begin
    metadata = text.split("\n")[0].split(/;\h*/).map(&:strip)
  rescue StandardError
    return text
  end

  publisher = metadata[0] || 'Desconhecido'
  orig_date = metadata[1] || 'Sem data'
  annote = metadata[2] ? "annote: #{text_to_title(metadata[2]).gsub(/'/, '')}" : ''
  if author == 'Fernando Rey Puente'
    publisher = 'lgr.com.br'
    date = '2022'
  end
  relative_path = path.gsub(BLOG_FOLDER, '')
  yml_view_url = "#{MKDOCS_REPO_URL}/commits/main#{relative_path.gsub(".md", "")}".downcase
  yml_delimiter = '---'

  author_name = "#{author.split(/\s+/)[-1].upcase}, #{author.gsub(author.split(/\s+/)[-1], '').strip}"
  editor_name = "#{editor.split(/\s+/)[-1].upcase}, #{editor.gsub(editor.split(/\s+/)[-1], '').strip}"

  vol_title = vol_title.empty? ? WORK_TITLE : "#{WORK_TITLE}, #{vol_title}"

  if author == AUTHOR2
    orig_pub = " Publicação original: #{text_to_title(publisher)}, #{orig_date}."
    orig_pub_bibtex = ["orig_publisher: #{text_to_title(publisher)}",
                       "orig_date: #{orig_date}", annote]
  else
    orig_pub = ''
    orig_pub_bibtex = []
  end

  abnt_ref = "#{author_name}. \"#{title}\". In#{author == editor ? "" : " #{editor_name} (org.)"} <em>#{vol_title}</em>, #{Time.now.strftime("%Y")}.#{orig_pub} URL: <a href=\"yml_view_url\">#{yml_view_url}</a>".gsub(/'/, '').gsub(/(^|$)/, "'")
  # p last_name_first(author)

  partial_yml_header = [yml_delimiter,
                        "title: #{text_to_title(title)}",
                        "author: #{author}",
                        "editor: #{editor}",
                        "vol_title: #{text_to_title(vol_title)}",
                        "date: #{Time.now.strftime("%Y-%m")}",
                        'print_bib: true',
                        "abnt_ref: #{abnt_ref}",
                        "view_url: #{yml_view_url}"].reject(&:empty?)
  yml_header = (partial_yml_header + orig_pub_bibtex + [yml_delimiter]).join("\n")

  "#{yml_header}\n\n#{text.lines[1..-1].join.strip}"
end
