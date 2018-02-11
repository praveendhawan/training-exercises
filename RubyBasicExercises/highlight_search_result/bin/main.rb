require_relative '../lib/string.rb'

printf 'Enter the string :'
input_string = gets.chomp
printf "\nEnter the pattern : "
pattern = gets.chomp
p input_string.highlight_and_count_search(pattern)
