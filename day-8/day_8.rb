require_relative 'cpu'

text = IO.read('input.txt')
cpu = Cpu.new(text)
cpu.execute
value = cpu.largest_value_in_any_register
puts "The largest value in any register is #{value}"
