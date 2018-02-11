require_relative './item.rb'
require_relative './cart.rb'
require_relative './price_calculator.rb'
class Checkout

  def self.show_details(cart)
    cart.items.each { |item| PriceCalculator.sales_tax(item); puts item }
    puts "Grand Total : #{ PriceCalculator.total_amount(cart.items).round }"
  end
end