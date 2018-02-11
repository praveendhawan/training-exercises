class Item
  attr_accessor :name, :quantity
  def initialize(name)
    @name, @quantity = name, 0
  end

  def add_quantity(quantity)
    @quantity += quantity 
  end

  def to_s
    "Name: #{ @name }, Quantity: #{ @quantity }\n"
  end
end