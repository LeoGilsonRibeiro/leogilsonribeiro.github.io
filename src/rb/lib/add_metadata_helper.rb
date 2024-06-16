# Adicionar metadados ao cabeçalho do arquivo markdown
def add_metadata(author, editor, title, text, vol_title, path)
  begin
    metadata = text.split(/\n/)[0].gsub(/\*/, '').split(/;/).map(&:strip)
    text = text.lines[1..-1].join.strip unless author == AUTHOR1
    # p metadata
  rescue StandardError
    return text
  end

  yml_delimiter = '---'
  date = '2022'
  date_bibtex = "date = {#{date}}"
  date_ris = "PY  - #{date}"
  id = "#{author.split(/\s+/)[-1]}#{date}"
  id_ris = "ID  - #{id}"
  author_name = "#{author.split(/\s+/)[-1].upcase}, #{author.gsub(author.split(/\s+/)[-1], '').strip}"
  author_name_bibtex = "author = {#{author_name}}"
  author_name_ris = "AU  - #{author_name}"
  editor_name = "#{editor.split(/\s+/)[-1].upcase}, #{editor.gsub(editor.split(/\s+/)[-1], '').strip}"
  editor_name_bibtex = "editor = {#{editor_name}}"
  editor_name_ris = "ED  - #{editor_name}"
  publisher = metadata[0] || 'Desconhecido'
  orig_date = metadata[1] || 'Sem data'
  relative_path = path.gsub(BLOG_FOLDER, '')
  commits_url = "#{MKDOCS_REPO_URL}/commits/main#{relative_path.gsub("", "")}"
  edit_url = "#{MKDOCS_REPO_URL}/edit/main/#{relative_path.gsub("", "")}"
  stable_url = "https://www.leogilsonribeiro.com.br#{relative_path.gsub(%r{(/docs/markdown|.md)}, "")}".gsub(%r{(readme|/$)}, '')
  stable_url_bibtex = "url = {#{stable_url}}"
  stable_url_ris = "UR  - #{stable_url}"

  if publisher == 'Desconhecido' && orig_date == 'Sem data'
    orig_pub = orig_pub_bibtex = orig_pub_ris = ''
    orig_date = orig_date_bibtex = orig_date_ris = ''
  else
    orig_pub = "#{text_to_title(publisher).strip}"
    orig_pub_abnt = " Publicação original: #{text_to_title(publisher).strip}, #{orig_date}."
    orig_pub_bibtex = "orig_publisher = {#{text_to_title(publisher).strip}}"
    orig_pub_ris = "PB  - #{text_to_title(publisher).strip}"
    orig_date_bibtex = "orig_date = {#{orig_date}}"
    orig_date_ris = "Y1  - #{orig_date}"
    orig_date = "#{orig_date}"
  end

  # orig_date = publisher == 'Desconhecido' && orig_date == 'Sem data' ? '' : "orig_date: #{orig_date}"
  # orig_pub_abnt = publisher == 'Desconhecido' && orig_date == 'Sem data' ? " Publicação original: #{text_to_title(publisher).strip}, #{orig_date}." : ''
  # orig_pub_bibtex = publisher == 'Desconhecido' && orig_date == 'Sem data' ? ["orig_publisher = {#{text_to_title(publisher).strip}}", "orig_date = {#{orig_date}}"] : []
  # orig_pub_ris = publisher == 'Desconhecido' && orig_date == 'Sem data' ? '' : ["PB  - #{text_to_title(publisher).strip}", "PY  - #{orig_date.strip}"].join("\n")

  annote = metadata[2] ? text_to_title(metadata[2]).gsub(/'/, '').to_s : ''
  annote_bibtex_field = annote.nil? || annote.empty? ? '' : "annote = {#{annote}},"
  annote_ris_field = annote.nil? || annote.empty? ? '' : "N1  - #{annote}"
  title_bibtex = "title = {#{title}}"
  title_ris = "TI  - #{title}"
  vol_title = vol_title.empty? ? WORK_TITLE : "#{WORK_TITLE}, #{vol_title}"
  vol_title_bibtex = "booktitle = {#{vol_title}}"
  vol_title_ris = "T2  - #{vol_title}"

  if author == 'Fernando Rey Puente'
    publisher = 'leogilsonribeiro.com.br'
    status = 'Transcrição completa. Aguardando revisão.'
    date = '2022'
    orig_pub = ''
    orig_pub_bibtex = ''
    orig_pub_ris = ''
    orig_pub_abnt = ''
    orig_date = 'orig_date: 2022'
    orig_date_bibtex = ''
    orig_date_ris = ''
    annote = ''
    annote_bibtex_field = ''
    annote_ris_field = ''
  else
    status = 'Transcrição completa.'
  end

  # p stable_url, yml_view_url
  abnt_ref = "#{author_name}. \"#{title}\". In#{author == editor ? "" : " #{editor_name} (org.)"} <em>#{vol_title}</em>, #{date}.#{orig_pub_abnt} URL: <a href=\"stable_url\">#{stable_url}</a>".gsub(/'/, '')

  bibtex = [author_name_bibtex, editor_name_bibtex, title_bibtex, vol_title_bibtex, date_bibtex, annote_bibtex_field, stable_url_bibtex, orig_pub_bibtex, orig_date_bibtex].flatten.reject(&:empty?).join(",\n    ")

  ris = ['TY  - WEB', id_ris, author_name_ris, editor_name_ris, title_ris, vol_title_ris, date_ris, orig_pub_ris, orig_date_ris, annote_ris_field, stable_url_ris, 'ER  - '].reject(&:empty?).join("\n    ")

  citation = "citation:\n  type: chapter\n  original-publisher: \"#{orig_pub}\"\n  original-date: \"#{orig_date}\""
  abstract = "abstract: \"#{orig_pub}, #{orig_date}. Aguardando revisão.\""
  partial_yml_header = [yml_delimiter,
                        "title: |\n  #{text_to_title(title).gsub(/'/,'')}",
                        "author: \"#{author}\"",
                        "date: \"#{date}\"",
                        citation,
                        abstract,
                        "status: #{status}"]


  bib_ref = %(
