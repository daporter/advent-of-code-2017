require_relative 'diagram'

input = IO.read('input.txt')
diagram = Diagram.parse(input)
diagram.move_packet_along_path
puts "The letters seen are: #{diagram.letters_seen}"
