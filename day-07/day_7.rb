require_relative 'tower'

input = IO.read('input.txt')
tower = Tower.from_list(input)

puts "The name of the bottom program is #{tower.program_name}"

wrong_program = tower.find_program_with_wrong_weight.program_name
puts "The program with the wrong weight is #{wrong_program}."
puts "It should have weight #{tower.corrected_weight}"
