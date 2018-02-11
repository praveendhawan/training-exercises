require_relative '../lib/string.rb'

input_string = ''
while !(input_string =~ /^q$/i)

  if !(input_string.empty?)
    p input_string.palindrome?
  end

  print 'enter a string : '
  input_string = gets.chomp

end
