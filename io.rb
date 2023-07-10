# frozen_string_literal: true

require 'open-uri'



web_file = URI.open("http://ruby.bastardsbook.com/files/fundamentals/hamlet.txt")
play_text = web_file.read
web_file.close

new_file = File.open("hamlet.txt", "w")
new_file.write(play_text)
new_file.close

File.open("hamlet.txt", "r") do |hamlet|
  hamlet.readlines.each_with_index do |line, index|
    puts line if (index % 42).zero?
  end
end
