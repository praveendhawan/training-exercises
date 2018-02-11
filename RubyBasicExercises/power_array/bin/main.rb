require_relative '../lib/array.rb'
printf 'please enter the size of array : '
array_size = gets.chomp.to_i

if array_size > 0
  array = Array.new()
  array.create_by_size(array_size) { printf 'enter element ' }
  printf 'please enter the power : '
  exponent = gets.chomp.to_i
  p array.power(exponent)
end
