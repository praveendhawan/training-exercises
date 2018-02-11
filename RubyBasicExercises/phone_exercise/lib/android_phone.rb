require_relative './phone.rb'

class AndroidPhone < Phone

  @@android_phone_in_stock = []
  
  def initialize(input_details)
    super
    AndroidPhone.add(self)
  end

  def self.add(phone)
    super
    @@android_phone_in_stock << phone
  end

  def self.all
    @@android_phone_in_stock.each { |mobile| puts mobile }
  end

end