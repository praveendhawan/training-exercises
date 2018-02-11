require_relative '../lib/time.rb'

printf 'enter first time (h:m:s) '
time1_string = gets.chomp
printf 'enter second time (h:m:s) '
time2_string = gets.chomp
result_time = Time.sum(time1_string, time2_string)
puts "#{ result_time.day - Time.now.day } days and #{ result_time.hour }:#{ result_time.min }:#{ result_time.sec }"
