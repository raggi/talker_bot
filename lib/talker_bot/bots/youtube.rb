require 'youtube'

class TalkerBot::Bots::YouTube
  attr_accessor :client

  def initialize
    abort "bzzzt, known broken atm"
    @toobes = YouTube::Client.new(File.read(ENV['HOME'] + '/.youtube').strip)
  end

  def on_message(sender, content, event)
    return if sender['name'] == 'bot'
    case content
    when /(.*) on youtube/
      client.send_message @toobes.search(:query => $1).first.url
    end
  end
end