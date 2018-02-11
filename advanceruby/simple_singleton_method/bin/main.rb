require_relative '../lib/string.rb'

name = "Praveen"

def name.say_hi
  "hello from #{ self }"
end

puts name.say_hi

another_name = "Dhawan"
puts another_name.say_hi

class << name
  def greet
    "Greetings from #{ self }"
  end
end

puts name.greet

puts another_name.greet