#
# A circular buffer that stores integer values.
#
class CircularBuffer
  attr_reader :value

  def initialize(value = 0, next_buf = self)
    @value = value
    @next = next_buf
  end

  def current_value
    @value
  end

  def size
    size_helper(self)
  end

  def step_forward(steps)
    steps.zero? ? self : @next.step_forward(steps - 1)
  end

  def insert(value)
    new_buf = CircularBuffer.new(value, @next)
    @next = new_buf
    new_buf
  end

  def values
    values_helper(self)
  end

  def next_value
    @next.value
  end

  protected

  def size_helper(start)
    @next == start ? 1 : 1 + @next.size_helper(start)
  end

  def values_helper(start)
    @next == start ? [@value] : [@value] + @next.values_helper(start)
  end
end
