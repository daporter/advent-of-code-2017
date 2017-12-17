require 'minitest/autorun'
require_relative 'memory_grid'

class MemoryGridTest < Minitest::Test

  # Data from square 1 is carried 0 steps, since it's at the access port.
  def test_from_1
    assert_equal 0, MemoryGrid.steps_from(1)
  end

  # Data from square 12 is carried 3 steps, such as: down, left, left.
  def test_from_12
    assert_equal 3, MemoryGrid.steps_from(12)
  end

  # Data from square 23 is carried only 2 steps: up twice.
  def test_from_23
    assert_equal 2, MemoryGrid.steps_from(23)
  end

  # Data from square 1024 must be carried 31 steps.
  def test_from_1024
    assert_equal 31, MemoryGrid.steps_from(1024)
  end

  # Data from square 347_991 takes 480 steps.
  def test_from_347_991
    assert_equal 480, MemoryGrid.steps_from(347_991)
  end
end
