require_relative '../lib/pascal.rb'
 printf 'Enter the size of pascal triangle '
 
 pascal_object = Pascal.new(gets.chomp.to_i)

 pascal_object.calculate_pascal { |pascal_value| printf " #{ pascal_value }" }
