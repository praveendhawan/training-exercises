class Array

  def create_by_size(array_size)
    array_size.times do
      yield
      self << gets.chomp.to_i
    end
  end

  def power(exponent)
    collect { |element| element ** exponent }
  end

end
