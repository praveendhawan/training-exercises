require 'prime'

class Fixnum

  def prime_using_step
    prime_number_array = []
    if self > 2
    1.step(self, 2){ |number| prime_number_array << number if number.prime? }
    end
    prime_number_array
  end

end
