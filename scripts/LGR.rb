#!/Users/bcdav/.rbenv/shims/ruby
# frozen_string_literal: false

require_relative '/Users/bcdav/Dropbox/Developer/Ruby/bin/rb_split_file'

start_time = Time.now

files = Dir['/Users/bcdav/Dropbox/Libraries/Blog/LGR/src/Docx_/*.docx']


files.each do |input_file|
  basename = File.basename(input_file, '.docx')
  destination = "/Users/bcdav/Dropbox/Libraries/Blog/LGR/src/Markdown/#{basename}.md"
  `pandoc "#{input_file}" -t markdown -o "#{destination}" --wrap=none`
end



time_diff = Time.now - start_time

puts "Script took #{time_diff}s"
