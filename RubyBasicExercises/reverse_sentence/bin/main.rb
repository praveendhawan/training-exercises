require_relative '../lib/sentence.rb'
printf 'enter a line : '
sentence = Sentence.new(gets.chomp)
p sentence.reverse
