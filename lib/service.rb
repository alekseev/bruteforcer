require 'mechanize'
require 'progress_bar'
require './lib/services/bitrix.rb'

class Service
  def self.force(agent, login, pass)
    Bitrix.force(agent, login, pass)
  end
end