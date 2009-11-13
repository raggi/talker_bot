class TalkerBot::Bots::Fortune
  attr_accessor :client
  def on_message(sender, content, event)
    return if sender['name'] == 'bot'
    case content
    when /!fortune/
      client.send_message `fortune`
    end
  end
end