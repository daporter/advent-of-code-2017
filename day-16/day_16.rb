require_relative 'dance'

input = IO.read('input.txt')
line = Dance.parse(input).perform
output = line.map(&:to_s).join
puts "After the dance the programs are standing in order #{output}"
