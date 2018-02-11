require_relative "../lib/customer.rb"

customer1 = Customer.new("Praveen")
puts customer1
customer1.deposit(100)
puts customer1
customer1.withdraw(50)
puts customer1

customer2 = Customer.new("David")
puts customer2
customer2.deposit(1100)
puts customer2
customer2.withdraw(200)
puts customer2
