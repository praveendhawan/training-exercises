require_relative '../lib/user_input.rb'
require_relative '../lib/cart.rb'
require_relative '../lib/checkout.rb'

choice = ""
cart = Cart.new

while choice != 'n'
  item = UserInput.take_details
  cart.add(item)
  printf "Do you want to add more items to your list(y/n) : "
  choice = gets.chomp
end

Checkout.show_details(cart)