require_relative './phone.rb'

class WindowsPhone < Phone

  @@Windows_phone_in_stock = []
  
  def initialize(input_details)
    super
    WindowsPhone.add(self)
  end

  def self.add(phone)
    super
    @@Windows_phone_in_stock << phone
  end

  def self.all
    @@Windows_phone_in_stock.each { |mobile| puts mobile }
  end

end