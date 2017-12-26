require_relative 'tower'

input = IO.read('input.txt')
tower = Tower.from_list(input)

puts "The name of the bottom program is #{tower.program_name}"
