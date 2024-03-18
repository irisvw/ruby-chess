class Square
  attr_accessor :value, :x, :y

  def initialize(x, y)
    @x = x
    @y = y
    @value = "·"
  end

  def to_s
    @value.to_s
  end

end