require_relative 'memory_grid'

square = 347_991
memory_grid = MemoryGrid.new
steps = memory_grid.steps_from(square)

puts "The number of steps from square #{square} is: #{steps}"

target = 347_991
memory_grid = MemoryGrid.new
first_value = memory_grid.first_value_larger_than(target)
puts "The first value larger than #{target} is: #{first_value}"
