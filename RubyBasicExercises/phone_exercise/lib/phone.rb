class Phone

  @@phones_in_stock = Hash.new { |hash, key| hash[key] = [] }
  attr_reader :details
  
  def initialize(input_details)
    @details = {:model_number => "", :imei => 0, :category => ''}
    @details.merge!(input_details)
  end

  def self.add(phone)
    @@phones_in_stock[phone.details[:category]] << phone
  end

  def self.all
    @@phones_in_stock.each { |phone| puts phone }
  end

  def to_s
    "#{ details[:model_number] } #{ details[:imei] }"
  end

end