# frozen_string_literal: false

# For bibliographical references
def last_name_first(str)
  str.gsub(/^(.+?) (\X+)$/, "#{$2.upcase}, \\1") unless str.nil? || str.empty?
end
