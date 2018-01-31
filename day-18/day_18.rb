require_relative 'tablet'

input = IO.read('input.txt')
tablet = Tablet.new(input)
tablet.run_programs
puts "Program 1's send count is #{tablet.program(1).send_count}"
