class Item
  attr_reader :name

  def initialize(arg)
    @name = arg[:name]
    @price = arg[:price]
  end

  def price
    @price[1..-1].to_f
  end
end
