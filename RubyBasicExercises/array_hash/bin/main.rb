require_relative '../lib/array.rb'

array = ['abc', 'def', 1234, 234, 'abcd', 'x', 'mnop', 5, 'zZzZ']
p array.group_by_length
