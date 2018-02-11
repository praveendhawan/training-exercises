class UserInput

  def self.take_input
    printf 'Enter the first operand '
    firstOperand = gets.chomp
    printf 'Enter the second operand '
    secondOperand = gets.chomp
    printf 'Enter the operator '
    operator = gets.chomp
    
    return { firstOperand: firstOperand, secondOperand: secondOperand, operator: operator }
  end

end