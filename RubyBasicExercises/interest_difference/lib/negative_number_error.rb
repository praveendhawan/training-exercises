class NegativeNumberError < Exception

  def initialize(msg = 'You either entered a negative number or zero')
    super
  end
  
end
