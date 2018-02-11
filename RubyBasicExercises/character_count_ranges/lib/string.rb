class String

  def classify_character
    lowercase_range, uppercase_range, digits_range = 'a'..'z', 'A'..'Z', '0'..'9'
    character_count = Hash.new(0)

    each_char do |character|

      case true
      when lowercase_range.include?(character)
        character_count[:lower] += 1
      when uppercase_range.include?(character)
        character_count[:upper] += 1
      when digits_range.include?(character)
        character_count[:digits] += 1
      else
        character_count[:special_chars] += 1
      end
    end

    character_count
  end

end
