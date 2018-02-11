require_relative './item.rb'

class UserInput
  def self.take_details
    item_details = {}		
    printf "Name of the product : "
    item_details[:name] = gets.chomp.strip
    printf "Imported? (yes/no): "
    item_details[:import_status] = gets.chomp.strip
    printf "Exempted from sales tax? (yes/no) : "
    item_details[:category] = gets.chomp.strip
    printf "Price : "
    item_details[:price] = Float(gets.chomp.strip)
    Item.new(item_details)
  end
  
end