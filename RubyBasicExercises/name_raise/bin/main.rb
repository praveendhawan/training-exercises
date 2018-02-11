require_relative '../lib/name.rb'
begin
  printf "Enter your first name :"
  first = gets.chomp
  printf "Enter your last name :"
  last = gets.chomp
  name = Name.new(first, last)
  puts "Name you entered is #{ name }"
rescue BlankStringError, CapitalLetterError => e
  puts e.message
  retry
end
