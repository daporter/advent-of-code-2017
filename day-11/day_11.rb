require_relative 'hex_path'

input = IO.read('input.txt').strip
path = HexPath.from_string(input)
puts "The fewest number of steps required is #{path.minimise.step_count}"
