class TimeValidator
  TIME_VALIDATOR_REGEX =  /^(([01]?[0-9])|2?[0-3]):([0-5]?[0-9]):([0-5]?[0-9])$/
  DATE_VALIDATOR_REGEX = /^(0?[1-9]|[12][0-9]|3[01])\/(0?[1-9]|1[0-2])\/((19|20)[0-9][0-9])$/
  class << self
    def time?(string)
      string.match(TIME_VALIDATOR_REGEX)
    end

    def date?(string)
      string.match(DATE_VALIDATOR_REGEX)
    end
  end

end
