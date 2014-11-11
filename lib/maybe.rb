class Maybe
  def initialize(raw_value)
    @raw_value = raw_value
  end

  def value_or(*args)
    if !@raw_value.nil?
      @raw_value
    elsif block_given?
      yield
    elsif args.length == 1
      args[0]
    else
      fail ArgumentError
    end
  end

  def select
    if @raw_value.nil?
      self
    else
      Maybe.new(yield @raw_value)
    end
  end
end

module Kernel
  def Maybe(raw_value)
    Maybe.new(raw_value)
  end
end
