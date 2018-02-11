require_relative "../lib/fibonacci_yield.rb"

loop do
  print "\nplease enter an integer to set the maximum limit or q|Q to exit : "
  max_limit_fibonacci = gets.chomp

  if max_limit_fibonacci =~ /^q$/i
    break
  elsif max_limit_fibonacci =~ /[a-z]/i
    next
  else
  max_limit_fibonacci = max_limit_fibonacci.to_i
  object_fibonacci_yield = FibonacciYield.new(0, 1, max_limit_fibonacci)
  object_fibonacci_yield.generate_fibonacci do |previous_number, current_number|
    p previous_number
    previous_number, current_number = previous_number + current_number, previous_number
    end
  end
end
