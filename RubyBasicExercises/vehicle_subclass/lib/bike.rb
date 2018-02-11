require_relative './vehicle.rb'

class Bike < Vehicle
  attr_reader :dealer

  def initialize(name, price, dealer)
    super(name, price)
    @dealer = dealer
  end
  def to_s
    "#{ name } #{ price } #{ dealer }"
  end

end
