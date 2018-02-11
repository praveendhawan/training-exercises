class DerivedClass < String

  def palindrome?
     downcase.eql?(reverse.downcase)
  end
  
  def character_count_hash
    count_character = Hash.new(0)
    each_char { |character| count_character[character] += 1 }
    count_character
  end

  def exclude?(other_string)
    !(include?(other_string))
  end

  def get_new_methods
    methods - String.new.methods
  end

end