require_relative 'firewall'

input = IO.read('input.txt')
fw = Firewall.from_string(input)
puts "The severity of the whole trip is #{fw.trip_severity}"
