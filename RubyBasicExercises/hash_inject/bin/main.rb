require_relative '../lib/array.rb'
require 'byebug'

array = ['abc', 'def', 1234, 234, 'abcd', 'x', 'mnop', 5, 'zZzZ']
#debugger
p array.to_odd_even_hash
