# frozen_string_literal: false

# Método para eliminar caracteres ilegais em nomes de arquivos
def string_to_path(str)
  str.unicode_normalize(:nfc)
#      .gsub(/\p{Mn}/, '')           z              # Remover acentos (normalizar decompondo e remover non-spacing marks)
     .gsub(/[\/?*#:|"'<>,.\\]*/, '')             # Remover caracteres proibidos em nomes de arquivos
     .gsub(/^(\X{1,70}\b)/, '\1')                # Limitar tamanho do nome de arquivo a aprox. 70 caracteres
     .gsub(/ /, '-')
     .gsub(/-+/, '-')
#      .downcase
end
