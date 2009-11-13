class TalkerBot::Bots::Greeter
  attr_accessor :client

  def on_message(sender, content, event)
    return if sender['name'] == 'bot'
    case content
    when /^@*bot:*\s+/
      client.send_message "Hi #{sender['name']}!"
    when /botsnack/
      client.send_message "botsnack, nom nom"
    end
  end

  def on_join(*users)
    users.each do |user|
      client.send_message "Welcome #{user['name']}, nice to see you!"
    end
  end
end