class String

  def character_count_hash
    count_character = Hash.new(0)

    each_char { |character| count_character[character] += 1 }

    count_character
  end

end
