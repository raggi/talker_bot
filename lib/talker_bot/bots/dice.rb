class TalkerBot::Bots::Dice
  attr_accessor :client
  def on_message(sender, content, event)
    return if sender['name'] == 'bot'
    case content
    when /(\d+)[dD](\d+)(?:\+(\d+))?/
      dice, faces, bonus = $1.to_i, $2.to_i, $3
      if dice >= 1000 || faces >= 10000
        return client.send_message("#{dice}d#{faces} is too large")
      end
      results = Array.new(dice){ 1+rand(faces) }
      total = results.inject { |t,v| t + v }
      total += bonus.to_i if bonus
      client.send_message "#{total} from #{results.inspect} #{"+#{bonus}" if bonus}"
    end
  end
end