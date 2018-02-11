require_relative './class_accessor.rb'
class Person
  extend ClassAccessor
  cattr_accessor :hair_style , {instance_writer: true}
end