require_relative './time_validator.rb'
require 'time'

class Time

  class << self
    
    def sum(input_array)
      addend = Time.parse("0:0:0")
      input_array.each do |time_string|
        if valid?(time_string)
          total_seconds = Time.parse(time_string).calculate_seconds
          addend += total_seconds
        end
      end
      addend
    end

    private

    def valid?(string)
      TimeValidator.time?(string)
    end

  end

  def calculate_seconds
    hour * 3600 + min * 60 + sec
  end

end
