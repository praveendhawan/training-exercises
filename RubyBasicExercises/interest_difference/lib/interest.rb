require_relative './negative_number_error'

class Interest
  RATE = 10
  def initialize(principal, time)
    valid?(principal, time)
    if block_given?
      @principal, @time, @rate = yield(principal), yield(time), RATE
    end
  end

  def calculate_difference_in_interest
    (calculate_compoundly - calculate_simply).abs
  end

  private 
  
  def calculate_simply
    (@principal * @time * @rate) * 0.01
  end

  def valid?(principal, time)
    raise NegativeNumberError if (principal < 0 || time < 0)
  end

  def calculate_compoundly
    @principal * (((@rate * 0.01 + 1) ** @time) - 1)
  end

end
