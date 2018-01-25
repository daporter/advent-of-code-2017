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
      steps = @steps % value
      steps.times { @buffer = @buffer.next }
      @buffer = @buffer.insert(value)
    end
  end

  def value_after_zero(times)
    position = 0
    after_zero = nil
    1.upto(times) do |value|
      position = (position + @steps) % value + 1
      after_zero = value if position == 1
    end
    after_zero
  end

  def next_value
    @buffer.next_value
  end
end
