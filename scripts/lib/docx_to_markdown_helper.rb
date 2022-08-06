# Converter arquivos docx em markdown realizando backup do arquivo original
def docx_to_markdown(docx_dir, markdown_dir, dry_run)
  Dir["#{docx_dir}**/*.docx"].each do |docx_file|
    if File.basename(docx_file).match(/^_/)
      # logger.info "Skipping #{docx_file}"
      next
    end

    # logger.info "Converting #{docx_file} with pandoc"
    markdown_file = "#{markdown_dir}/#{File.basename(docx_file, '.docx')}"
    `pandoc "#{docx_file}" -t markdown -o "#{markdown_file}.md" --wrap=none` unless dry_run
    # logger.info "Converted #{docx_file} to #{markdown_file}"
  end
end
