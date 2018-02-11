class Sentence < String

  def reverse
    split.reverse.join(" ")
  end

end
