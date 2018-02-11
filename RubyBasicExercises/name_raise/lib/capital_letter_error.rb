class CapitalLetterError < StandardError

  def message
    'String does not start with a capital letter '
  end
  
end
