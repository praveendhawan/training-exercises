require_relative '../lib/interest.rb'

begin
printf 'Enter the principal amount '
principal = Float(gets.chomp)
printf 'Enter the time period ( in years )'
time = Float(gets.chomp)
interest_obj = Interest.new(principal, time) { |value| value }
puts "#{ interest_obj.calculate_difference_in_interest }"
rescue NegativeNumberError => e
  puts e.message
  retry
end
