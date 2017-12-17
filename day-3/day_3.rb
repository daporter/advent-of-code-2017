require_relative 'memory_grid'

square = 347_991
memory_grid = MemoryGrid.new
steps = memory_grid.steps_from(square)

puts "The number of steps from square #{square} is: #{steps}"
