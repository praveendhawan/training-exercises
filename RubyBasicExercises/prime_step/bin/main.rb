require_relative '../lib/fixnum.rb'
printf 'enter maximum limit for generating primes : (>2) '
max_limit = gets.chomp.to_i
p max_limit.prime_using_step
