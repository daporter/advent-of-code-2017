require_relative 'cpu'

lines = IO.readlines('input.txt')
instructions_simple = lines.map(&:to_i)
simple_cpu = SimpleCpu.new(instructions_simple)
simple_cpu.execute
puts "It takes the simple CPU #{simple_cpu.steps} steps to reach the exit"

lines = IO.readlines('input.txt')
instructions_complex = lines.map(&:to_i)
complex_cpu = ComplexCpu.new(instructions_complex)
complex_cpu.execute
puts "It takes the complex CPU #{complex_cpu.steps} steps to reach the exit"
