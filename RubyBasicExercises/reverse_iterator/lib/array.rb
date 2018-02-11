class Array

  def reverse_iterate
    index = length - 1
    while index >= 0
      yield(self[index])
      index -= 1
    end
  end

end
