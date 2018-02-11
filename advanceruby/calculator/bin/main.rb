require_relative '../lib/calculator.rb'
require_relative '../lib/user_input.rb'
require_relative '../lib/calculator/not_valid_input_error.rb'
require_relative '../lib/calculator/validate_input.rb'

begin
  puts 'Please Enter the details'
  input_hash = UserInput.take_input
  calculator = Calculator.new(input_hash)
  rescue Calculator::NotValidInputError, StandardError => e
  puts e.message
  retry
end
puts calculator.calculate