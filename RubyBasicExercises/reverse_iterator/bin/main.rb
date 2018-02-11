require_relative '../lib/array.rb'

[2, 4, 6, 8].reverse_iterate { |item| print "#{ item } " }
