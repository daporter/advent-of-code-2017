require_relative 'cpu'

lines = IO.readlines('input.txt')
instructions = lines.map(&:to_i)
cpu = Cpu.new(instructions)
cpu.execute

puts "It takes #{cpu.steps} steps to reach the exit"
