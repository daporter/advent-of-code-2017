require 'minitest/autorun'
require_relative 'circular_buffer'

#
# Unit tests for class CircularBuffer.
#
class CircularBufferTest < Minitest::Test
  def test_new
    cb = CircularBuffer.new
    assert_equal 1, cb.size
    assert_equal 0, cb.current_value
  end

  def test_step_forward
    cb = CircularBuffer.new
    assert_equal 0, cb.step_forward(3).current_value
  end

  def test_insert
    cb = CircularBuffer.new.insert(1)
    assert_equal 2, cb.size
    assert_equal 1, cb.current_value
  end
end
