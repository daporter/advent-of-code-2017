require_relative 'memory_reallocator'

banks = IO.read('input.txt').strip.split.map(&:to_i)
mr = MemoryReallocator.new(banks)
mr.execute
puts "#{mr.cycles} cycles must be completed until a previous configuration is seen."
puts "There are #{mr.cycles_in_loop} in the infinite loop."
