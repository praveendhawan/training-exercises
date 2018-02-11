require_relative './relationships.rb'
class User

  extend Relationships

  attr_accessor :name, :age, :id
  has_many :orders, Order
  
  def initialize(name, age)
    @id = ObjectSpace.each_object(self.class) { |user| user }
    @name, @age = name, age
  end

  def self.create(*args)
    isvalid = args.length >= 2 ? valid?(args[0]) : false
    if(isvalid)
      new_user = new(args[0].strip, args[1])
    end
  end

  def self.valid?(name)
    name = name.strip
    isvalid = name.length > 5
    isvalid &&= !(ObjectSpace.each_object(self).map { |user| user.name == name }.include?(true))
  end

  def self.all
    ObjectSpace.each_object(User) { |user| puts user }
  end

  def to_s
    "Id : #{ id } Name : #{ name } Age : #{ age }"
  end

end