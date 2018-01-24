require_relative 'circular_buffer'

#
# A spinlock.
#
class Spinlock
  def initialize(steps)
    @steps = steps
    @buffer = CircularBuffer.new
  end

  def values
    @buffer.values
  end

  def insert(times)
    1.upto(times) do |value|
      @buffer = @buffer.step_forward(@steps)
      @buffer = @buffer.insert(value)
    end
  end

  def next_value
    @buffer.next_value
  end
end
