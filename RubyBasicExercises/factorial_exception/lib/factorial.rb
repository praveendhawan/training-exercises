require_relative 'negative_number_error.rb'

class Factorial

  def self.calculate(number)
    raise NegativeNumberError if number < 0
    (1..number).inject(1) { |result, counter| result *= counter }
  end

end
