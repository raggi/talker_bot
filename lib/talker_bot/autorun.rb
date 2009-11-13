require 'talker_bot'

@bot = TalkerBot.new

require 'forwardable'
include SingleForwardable

def_delegators :@bot, *TalkerBot.instance_methods(false)

config :room, ARGV.first

at_exit { EM.run { @bot.run } }