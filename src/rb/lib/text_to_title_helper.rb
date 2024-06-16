# frozen_string_literal: false
def text_to_title(str)
  str.strip
     .gsub(/\.*$/, '')
     .gsub(/[*]/, '')
     .gsub(/Volume\W+(\d+):\W+/) { |_m| "Volume #{convert_to_new_roman(Regexp.last_match(1).to_i)}: " }
     .gsub(/--/, '-')
     .gsub('/', '-')
     .gsub(/'/, '')
#      .gsub(/(^|$)/, "'")
end
