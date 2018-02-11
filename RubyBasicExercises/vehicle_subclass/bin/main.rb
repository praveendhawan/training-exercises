require_relative '../lib/vehicle.rb'
require_relative '../lib/bike.rb'

bike = Bike.new('Twister', 50000, 'Praveen')
puts bike
bike.price = 55000
puts bike
