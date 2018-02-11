class FibonacciYield

  def initialize(first_number, second_number, max_limit)
    @first_series_number, @second_series_number, @max_fibonacci_limit = first_number, second_number, max_limit
  end

  def generate_fibonacci
    previous_number, current_number = @first_series_number, @second_series_number

    while previous_number <= @max_fibonacci_limit
      previous_number, current_number = yield previous_number, current_number
    end
  end

end
