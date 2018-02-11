require_relative '../lib/user_input.rb'
require_relative '../lib/windows_phone.rb'
require_relative '../lib/android_phone.rb'
require_relative '../lib/ios_phone.rb'

begin
  choice = ''
  while choice != 'n'
    phone_details = {}
    phone_details = UserInput.get_details
    case phone_details[:category]
    when "windows"
      windows_phone = WindowsPhone.new(phone_details)
    when "android"
      android_phone = AndroidPhone.new(phone_details)
    when "ios"
      ios_phone = IosPhone.new(phone_details)
    end
    print "Do you want to add more phones (y/n)"
    choice = gets.chomp
  end
rescue InvalidInput => e
  puts e.message
  retry
end

Phone.all

WindowsPhone.all

IosPhone.all

AndroidPhone.all