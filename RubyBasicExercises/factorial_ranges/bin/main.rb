require_relative '../lib/fixnum.rb'
printf 'enter the number for which you want to calculate factorial : '
number = gets.chomp.to_i
p number.factorial
