class InteractiveProgram
  attr_accessor :input_to_evaluate
  
  def initialize
    @input_to_evaluate = ''
  end

  def start
    puts 'Start entering commands'
    current_input_string = ''
    while(current_input_string.chomp != 'q')
      current_input_string = UserInput.take_input
      @input_to_evaluate.concat(current_input_string)
      if(current_input_string.chomp.empty?)
        evaluate
      end
    end
  end

  def evaluate
    eval(@input_to_evaluate)
    @input_to_evaluate = ''
  end

end