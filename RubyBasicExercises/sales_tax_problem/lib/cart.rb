require_relative 'item.rb'

class Cart
  attr_reader :items
  @grand_total = 0
  def initialize()
    @items = []
  end

  def add(item)
    @items << item
  end

  def calculate_grand_total
    @grand_total = PriceCalculator.total_amount(items)
  end

end