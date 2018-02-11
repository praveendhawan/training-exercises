class Pascal
  def initialize(pascal_limit)
    @pascal_upto = pascal_limit
  end

  def factorial(number)
    number > 0 ? (1..number).inject { |result, counter| result *= counter } : 1
  end

  def combination(first_number, second_number)
    factorial(first_number) / (factorial(second_number) * factorial(first_number - second_number))
  end

  def calculate_pascal
    0.upto(@pascal_upto) do |row|
      0.upto(row) do |column|
        yield (combination(row, column))
      end
      yield("\n")
    end

  end

end
