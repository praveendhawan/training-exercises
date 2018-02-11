class Calculator::NotValidInputError < ArgumentError
  def initialize(msg = 'Arguments are not of valid range')
    super
  end
end