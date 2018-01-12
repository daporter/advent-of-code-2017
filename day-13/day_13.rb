require_relative 'firewall'

input = IO.read('input.txt')
fw = Firewall.from_string(input)
puts "The severity of the whole trip is #{fw.trip_severity}"

fw = Firewall.from_string(input)
delay = fw.min_delay_to_pass_through
puts "The shortest delay needed for the packet to pass through is #{delay} picoseconds"
