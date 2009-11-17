require 'talker'
require 'talker/cli'
require 'subload'

class TalkerBot
  VERSION = '1.0.0'
  TALKER_OPTS = [:host, :port, :room, :token]
  TALKER_CALLBACKS = Talker.instance_methods.grep(/^on_/).map { |m| m.to_sym }
  UNDERSCORE = '_'

  module Bots
    subload :Cat
    subload :Youtube
    subload :Greeter
    subload :Fortune
    subload :Dice
    subload :Inspector
  end

  def self.start(config = {}, &block)
    bot = new(config)
    bot.instance_eval(&block) if block
    bot.connect
    bot.run
  end

  def initialize(config = {})
    @config = config
    config[:token] ||= Talker::CLI.load_token
    @plugins = []
    @plugin_callbacks = Hash.new { |h,k| h[k] = [] }
  end

  def config(name, value = nil)
    if value
      @config[name] = value
    else
      @config[name]
    end
  end

  def plugin(plugin)
    @plugins << plugin
    TALKER_CALLBACKS.each do |callback|
      @plugin_callbacks[callback] << plugin if plugin.respond_to?(callback)
    end
  end
  alias use plugin

  def connect
    @connection = Talker.connect(@config) do |client|
      TALKER_CALLBACKS.each do |cb|
        client.__send__(cb) { |*args| event(cb, *args) }
      end
      @plugins.each do |p|
        p.bot = client if p.respond_to?(:bot=)
        p.client = client if p.respond_to?(:client=)
      end
    end
  end
  alias run connect

  def event(type, *args)
    @plugin_callbacks[type].each { |plugin| plugin.__send__(type, *args) }
  end
end