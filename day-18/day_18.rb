require_relative 'tablet'

input = IO.read('input.txt')
tablet = Tablet.new(input)

puts "The recovered frequency is #{tablet.run_until_frequency_recovered}"
