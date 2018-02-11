require_relative '../lib/time.rb'
printf 'enter the number of times you want to add '
argument_lentgh = gets.chomp.to_i
input_time_array = []
1.upto(argument_lentgh) do |variable|
  printf "enter #{ variable } time string (h:m:s) "
  input_time_array << gets.chomp
end
result_time = Time.sum(input_time_array)
puts "#{ result_time.day - Time.now.day } days and #{ result_time.hour }:#{ result_time.min }:#{ result_time.sec }"
