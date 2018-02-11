require_relative './dirty_object.rb'

class User
  include DirtyObject
  attr_accessor :name, :email, :age
  define_dirty_attributes :name, :age
  
  def initialize
    super
  end

end