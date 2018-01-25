require_relative 'spinlock'

spinlock = Spinlock.new(337)
spinlock.insert(2017)
puts "The value after 2017 is #{spinlock.next_value}"

spinlock = Spinlock.new(337)
value = spinlock.value_after_zero(50_000_000)
puts "The value after 0 is #{value}"
