require_relative '../lib/user.rb'

u = User.new

u.name  = 'Akhil'
u.email = 'akhil@vinsol.com'
u.age   = 30

p u.changed? #=> true
p u.changes  #=> { name: [nil, 'Akhil], age: [nil, 30] }

p u.name_was   #=> nil
# u.email_was  #=> undefined method.....
p u.age_was    #=> nil

p u.save       #=> true


p u.changed?   #=> false
p u.changes    #=> {}

u.name = 'New name'
u.age  = 31
p u.changes   #=> {name: ['Akhil', 'New name'], age: [30, 31]}
p u.name_was  #=> 'Akhil'

u.name = 'Akhil'
p u.changes   #=> {age: [30, 31]}
p u.changed?  #=> true

u.age = 30
p u.changes   #=> {}
p u.changed?  #=> false
