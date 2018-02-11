require_relative './invalid_input.rb'

class UserInput

  def self.get_details
    
    phone_details = {}   
    
    printf "Model of the product : "
    phone_details[:model_number] = gets.chomp
    printf "IMEI of the product : "
    phone_details[:imei] = gets.chomp.to_i
    printf "Category of the product : (windows/ android/ ios)"
    phone_details[:category] = gets.chomp

    raise InvalidInput if (phone_details[:model_number].empty? || phone_details[:imei] == 0)
    
    phone_details
  end

end