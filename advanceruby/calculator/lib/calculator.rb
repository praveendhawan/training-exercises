class Calculator

  def initialize(input_hash)
    raise NotValidInputError unless valid?(input_hash)
    @firstOperand = to_float_or_fixnum(input_hash[:firstOperand])
    @operator = input_hash[:operator].to_sym
    @secondOperand = to_float_or_fixnum(input_hash[:secondOperand])
  end

  def valid?(input_hash)
    ValidateInput.is_valid_numeric?(input_hash[:firstOperand], input_hash[:secondOperand]) && ValidateInput.is_valid_operator?(input_hash[:operator])
  end

  def calculate
    @firstOperand.send(@operator, @secondOperand)
  end

  def to_float_or_fixnum(input_string)
    input_string.include?('.') ? input_string.to_f : input_string.to_i
  end

end
