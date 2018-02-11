class Array

  def group_by_length
    hash_by_length = Hash.new { |hash, key| hash[key] = [] }

    for element_array in self
      hash_by_length[element_array.to_s.length] << element_array
    end

    hash_by_length

  end

end
