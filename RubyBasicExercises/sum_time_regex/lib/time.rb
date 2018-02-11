require_relative './time_validator.rb'
require 'time'

class Time

  def self.sum(string1, string2)
    if validate(string1) && validate(string2)
      augend_time, addend_time = [ string1, string2 ].map { |string| Time.parse(string) }
      total_seconds = augend_time.hour * 3600 + augend_time.min * 60 + augend_time.sec
      addend_time + total_seconds
    end
  end

  def self.validate(string)
    TimeValidator.time?(string)
  end
end
