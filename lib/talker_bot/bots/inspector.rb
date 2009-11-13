class TalkerBot::Bots::Inspector
  def respond_to?(name)
    true if name.to_s =~ /^on_/
  end

  def method_missing(name, *args)
    p [name, args]
  end
end