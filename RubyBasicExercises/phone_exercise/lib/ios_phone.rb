require_relative './phone.rb'

class IosPhone < Phone

  @@ios_phone_in_stock = []
  
  def initialize(input_details)
    super
    IosPhone.add(self)
  end

  def self.add(phone)
    super
    @@ios_phone_in_stock << phone
  end

  def self.all
    @@ios_phone_in_stock.each { |mobile| puts mobile }
  end

end