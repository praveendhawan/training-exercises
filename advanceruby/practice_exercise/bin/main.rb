require_relative '../lib/orders.rb'
require_relative '../lib/users.rb'

u = User.create("Praveen", 21)
u2 = User.create("", 21)

u.create_orders("order1")
u.create_orders("order2")
u.create_orders("order3")

puts "Orders of #{ u.name }"
puts u.orders

u2 = User.create("Dhawan", 22)
u2.create_orders("order2")
u2.create_orders("order3")

puts "Orders of #{ u2.name }"
puts u2.orders

puts "All Users"
User.all