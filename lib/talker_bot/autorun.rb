require 'talker_bot'

@bot = TalkerBot.new

require 'forwardable'
include SingleForwardable

def_delegators :@bot, *TalkerBot.instance_methods(false)

config :room, ARGV.first

at_exit do
  EM.run {
    trap('INT') { EM.stop if EM.reactor_running?; exit }
    @bot.run
  }
end