require_relative 'spinlock'

spinlock = Spinlock.new(337)
spinlock.insert(2017)
puts "The value after 2017 is #{spinlock.next_value}"
