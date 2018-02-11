require_relative '../lib/derived_class.rb'

puts 'Please enter a string'
object = DerivedClass.new(gets.chomp)

puts 'Please enter a method name from the following list'

puts "#{ object.get_new_methods - [:get_new_methods] }"
method_to_call = object.class.instance_method(gets.chomp)

arguments = []
method_to_call.arity.times do |i|
  puts "Enter argument #{ i + 1 }"
  arguments << gets.chomp
end

p method_to_call.bind(object).call(*arguments)


