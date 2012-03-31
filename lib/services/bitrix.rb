class Bitrix
  def self.force(agent, login, pass)
    form = agent.page.forms.first
    form.USER_LOGIN = login
    form.USER_PASSWORD = pass
    begin
      form.submit
    rescue Net::HTTP::Persistent::Error => e
      puts "Connection error."
      exit
    end
    if agent.page.forms.count != 1
      puts pass
      exit
    end
  end
end