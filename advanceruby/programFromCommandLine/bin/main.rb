require_relative '../lib/class_generator.rb'

print "Please enter class name : "
class_name = gets.chomp

print "Please enter the method name : "
method_name = gets.chomp

print "Please enter the code for method : "
method_code = gets.chomp

class_name = ClassGenerator.create(class_name)
method = ClassGenerator.add_instance_method(class_name, method_name, method_code)

puts "Your class #{ class_name } is ready with method #{ method_name }"
puts "Calling #{ class_name }.new.#{ method_name } : "

puts class_name.new.public_send(method)