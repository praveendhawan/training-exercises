require_relative '../lib/factorial.rb'
begin
printf 'enter the number for which you want to calculate factorial : '
p Factorial.calculate(gets.chomp.to_i)
rescue NegativeNumberError => e
  puts e.message
  retry
end
