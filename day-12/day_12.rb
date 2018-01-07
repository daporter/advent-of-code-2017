require_relative 'digital_plumber'

input = IO.read('input.txt')
plumber = DigitalPlumber.pipe_sets_from_string(input)
num_programs = plumber.program_group(0).size
puts "There are #{num_programs} programs in the group that contains program 0"
