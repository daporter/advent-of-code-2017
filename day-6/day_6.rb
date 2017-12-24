require_relative 'memory_reallocator'

banks = IO.read('input.txt').strip.split.map(&:to_i)
mr = MemoryReallocator.new(banks)
cycles = mr.cycles_until_loop_detected

puts "#{cycles} cycles must be completed until a previous configuration is seen."
