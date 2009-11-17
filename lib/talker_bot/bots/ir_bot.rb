require 'talker_bot/autorun'
require 'ir'

class IrBot
  attr_accessor :bot

  def initialize
    @ir = Ir.new(:output => self, :inspector => method(:inspector))
    @users = Hash.new { |h,k| h[k] = '' }
  end

  def print(*args)
    bot.send_message args.join("\n")
  end

  def on_message(sender, content)
    return if sender == bot.current_user
    @users[sender] << content
    return unless syntax_ok?(@users[sender])
    @ir << @users[sender]
    @users[sender] = ''
  end

  def on_leave(*users)
    users.each { |u| @users.delete(u) }
  end
  
  def syntax_ok?(buffer)
    catch(:ok) { eval("BEGIN{throw:ok,true}; _ = #{buffer}") }
  rescue SyntaxError
    false
  end
  
  def inspector(ir, o)
    bot.send_message o.inspect
  end
end

use IrBot.new