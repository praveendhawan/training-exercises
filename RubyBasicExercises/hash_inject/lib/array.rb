class Array

  def group_by_length
    hash_by_length = Hash.new { |hash, key| hash[key] = [] }
    for element_array in self
      hash_by_length[element_array.to_s.length] << element_array
    end
    hash_by_length
  end

  def to_odd_even_hash
    odd_even_length_hash = group_by_length

    odd_even_length_hash.inject(Hash.new { |hash, key| hash[key] = [] }) do |result_hash,(key, value)|
      (key % 2 == 1) ? result_hash[:odd] << value : result_hash[:even] << value
      result_hash
    end
    
  end

end
