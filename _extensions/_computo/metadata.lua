

-- For each document in the Quarto project, check if the citation: {original_publisher: } field is set. If so, return the value of the field. If not, return an empty string.
function Doc (doc)
  local function get_options(meta)
    if meta['title'] then
        return {original_publisher = meta['title']}
    else
        return {}
    end
  end

  print(get_options(doc.meta).original_publisher)
end

print("teste")
