require_relative 'blank_string_error.rb'
require_relative 'capital_letter_error.rb'

class Name

  def initialize(first, last)
    @first = first if valid?(first)
    @last = last if empty?(last)
  end

  private
    def valid?(string)
      empty?(string)
      (string.capitalize != string) ? (raise CapitalLetterError) : true
    end

    def empty?(string)
      string.empty? ? (raise BlankStringError) : true
    end

    def to_s
      "#{ @first } #{ @last }"
    end

end
