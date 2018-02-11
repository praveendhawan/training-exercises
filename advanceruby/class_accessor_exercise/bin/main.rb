require_relative '../lib/person.rb'
require_relative '../lib/male.rb'

Person.hair_style = [:brown, :blue, :red, :black]

p Person.hair_style

Male.hair_style = [:brown, :blue, :red, :green, :black]

p Person.hair_style

p Male.hair_style
