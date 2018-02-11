class Order

  attr_accessor :id, :description, :user_id
  def initialize(description, user_id)
    @id = ObjectSpace.each_object(self.class) { |order| order }
    @description, @user_id = description, user_id
  end

  def to_s
    "ID : #{ id }, USER_ID : #{ user_id } DESCRIPTION : #{ description }"
  end

end