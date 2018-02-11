require_relative './item.rb'

class ShoppingList
  def initialize
    @items = {}
  end

  def add_item(item_name, quantity)
    if(quantity > 0)
      item = find_or_initialize_item(item_name)
      item.add_quantity(quantity)
      @items[item_name] = item
    end
  end

  def find_or_initialize_item(item_name)
    @items.has_key?(item_name) ? @items[item_name] : Item.new(item_name)
  end

  def listItems(&block)
    instance_eval(&block)
  end

  def viewList
    @items.each do |key, item|
      puts item.to_s
    end
  end
end