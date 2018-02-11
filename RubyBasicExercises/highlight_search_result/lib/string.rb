class String

  def highlight_search(regex_pattern)
    gsub(regex_pattern, '(\1)')
  end

  def count_search_occurance(regex_pattern)
    scan(regex_pattern).length
  end

  def highlight_and_count_search(pattern)
    regex_pattern = /(#{ pattern })/i
    { string: highlight_search(regex_pattern), occurance: count_search_occurance(regex_pattern) }
  end

end
