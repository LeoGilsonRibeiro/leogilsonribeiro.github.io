#!/Users/bcdav/.rbenv/shims/ruby
# frozen_string_literal: false

Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

start_time = Time.now

# require 'json'
require 'tempfile'
require 'fileutils'

replace = false
folders = Dir['/Users/bcdav/Dropbox/Blog/LGR/docs/src/**/']
files = Dir['/Users/bcdav/Dropbox/Blog/LGR/docs/src/**/*.md']

links = {  }

files.each do |input_file|
  destination = input_file.gsub(/.md/, '/')
  condition = /#{links.keys.join("|")}/ # Condition for editing lines

  raise 'ERROR: Ex nihilo nihil fit! Read Parmenides and specify an existing file!' unless input_file && File.exist?(input_file)

  temp_file = Tempfile.new('random_file')

  begin
    lines = File.open(input_file, 'r').readlines

    lines.each do |line|
      if line =~ condition # Changes to be performed
        replace = true
        links.each { |k, v| line.gsub!(k.to_s, v.to_s) }
      else
        line
      end
    end

    final_text = lines.join
    temp_file.puts final_text
    temp_file.close

    if folders.include?(destination) & final_text['prototype: Header']
      FileUtils.mv(temp_file.path, "#{destination}/README.md")
      FileUtils.rm_rf(input_file)
    elsif replace == true
      FileUtils.mv(temp_file.path, input_file)
    end
  ensure
    temp_file.close
    temp_file.unlink
  end
end

time_diff = Time.now - start_time

puts "Script took #{time_diff}s to fix this mess"
