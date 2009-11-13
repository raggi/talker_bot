class TalkerBot::Bots::Cat
  def client=(client)
    Thread.new do
      while true
        client.send_message $stdin.readline.chomp
      end
    end
  rescue EOFError
    exit!
  end
end