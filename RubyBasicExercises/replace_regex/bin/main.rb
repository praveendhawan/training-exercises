require_relative "../lib/string.rb"

print "enter a string  : "
input_string = gets.chomp
print "\nenter the pattern you want to replace with  : "

puts "#{ input_string.substitute_vowels_with(gets.chomp) }"
