require 'talker_bot'

@bot = TalkerBot.new

require 'forwardable'
include SingleForwardable

def_delegators :@bot, *TalkerBot.instance_methods(false)

at_exit { EM.run { @bot.run } }