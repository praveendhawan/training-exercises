require 'bigdecimal'

class Calculator::ValidateInput

   def self.is_valid_numeric?(*input_args)
    is_valid = true
    input_args.inject do |is_valid, num|
      num = BigDecimal.new(num)
      if(num.exponent.zero? && num.frac.zero?)
        is_valid = is_valid && false
      else
        is_valid = is_valid && true
      end
    end
      is_valid
  end

  def self.is_valid_operator?(operator)
    ['+', '-', '/', '*', '%', '**'].include?(operator)
  end

end