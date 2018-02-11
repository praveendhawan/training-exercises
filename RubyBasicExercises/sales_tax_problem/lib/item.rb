class Item

  attr_reader :details
  def initialize(input_arguments)
    @details = {name: '', price: 0, import_status: 'no', category: 'no', tax: 0 }
    @details.merge!(input_arguments)
  end

  def import_status?
    details[:import_status].match(/yes/i)
  end

  def category?
    details[:category].match(/yes/i)
  end

  def to_s
    "Name : #{ @details[:name] } Price : #{ @details[:price] } Tax : #{ @details[:tax] } "
  end

end
