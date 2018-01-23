require_relative 'dance'

input = IO.read('input.txt')
dance = Dance.parse(input)

line = dance.perform
puts "After 1 dance the programs are #{Dance.line_s(line)}"

num_dances = 1_000_000_000
line = dance.perform_n(num_dances)
puts "After #{num_dances} dances the programs are #{Dance.line_s(line)}"
