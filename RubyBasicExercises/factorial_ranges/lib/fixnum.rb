class Fixnum
  def factorial
    if self > 0
      (1..self).inject(1) { |result, counter| result *= counter }
    else
      "please enter a positive number"
    end
  end

end
