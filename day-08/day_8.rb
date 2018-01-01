require_relative 'cpu'

text = IO.read('input.txt')
cpu = Cpu.new(text)
cpu.execute
largest_value = cpu.largest_value_in_any_register
largest_value_held = cpu.largest_value_held
puts "The largest value in any register is #{largest_value}"
puts "The largest value held in any register during execution is #{largest_value_held}"
