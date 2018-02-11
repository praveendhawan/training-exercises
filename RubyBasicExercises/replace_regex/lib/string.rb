class String
  VOWEL_REGEX = /[aeiou]/i;

  def substitute_vowels_with(pattern)
    gsub(VOWEL_REGEX, pattern)
  end

end
