require_relative 'hex_path'

input = IO.read('input.txt').strip
path = HexPath.from_string(input)
path_min = path.minimise
puts "The fewest number of steps required is #{path_min.step_count}"
puts "The furthest point from the start is #{path.furthest_from_start} steps"
