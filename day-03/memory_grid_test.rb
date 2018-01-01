require 'minitest/autorun'
require_relative 'memory_grid'

class MemoryGridTest < Minitest::Test

  # Data from square 1 is carried 0 steps, since it's at the access port.
  def test_steps_from_1
    memory_grid = MemoryGrid.new
    assert_equal 0, memory_grid.steps_from(1)
  end

  # Data from square 12 is carried 3 steps, such as: down, left, left.
  def test_steps_from_12
    memory_grid = MemoryGrid.new
    assert_equal 3, memory_grid.steps_from(12)
  end

  # Data from square 23 is carried only 2 steps: up twice.
  def test_steps_from_23
    memory_grid = MemoryGrid.new
    assert_equal 2, memory_grid.steps_from(23)
  end

  # Data from square 1024 must be carried 31 steps.
  def test_steps_from_1024
    memory_grid = MemoryGrid.new
    assert_equal 31, memory_grid.steps_from(1024)
  end

  # Data from square 347_991 takes 480 steps.
  def test_steps_from_347_991
    memory_grid = MemoryGrid.new
    assert_equal 480, memory_grid.steps_from(347_991)
  end

  def test_neighbour_horizontal
    square_x = GridSquare.new(1, 0, 0)
    square_y = GridSquare.new(2, 1, 0)
    assert_equal true, square_y.neighbour?(square_x)
  end

  def test_neighbour_vertical
    square_x = GridSquare.new(2, 1, 0)
    square_y = GridSquare.new(3, 1, -1)
    assert_equal true, square_y.neighbour?(square_x)
  end

  def test_neighbour_diagonal
    square_x = GridSquare.new(2, 1, 0)
    square_y = GridSquare.new(4, 0, -1)
    assert_equal true, square_y.neighbour?(square_x)
  end

  def test_not_neighbour_horizontal
    square_x = GridSquare.new(3, 1, -1)
    square_y = GridSquare.new(5, -1, -1)
    assert_equal false, square_y.neighbour?(square_x)
  end

  def test_not_neighbour_vertical
    square_x = GridSquare.new(5, -1, -1)
    square_y = GridSquare.new(7, -1, 1)
    assert_equal false, square_y.neighbour?(square_x)
  end

  def test_not_neighbour_diagonal
    square_x = GridSquare.new(2, 1, 0)
    square_y = GridSquare.new(5, -1, -1)
    assert_equal false, square_y.neighbour?(square_x)
  end

  def test_first_value_larger_than_0
    memory_grid = MemoryGrid.new
    assert_equal 1, memory_grid.first_value_larger_than(0)
  end

  def test_first_value_larger_than_1
    memory_grid = MemoryGrid.new
    assert_equal 2, memory_grid.first_value_larger_than(1)
  end

  def test_first_value_larger_than_2
    memory_grid = MemoryGrid.new
    assert_equal 4, memory_grid.first_value_larger_than(2)
  end

  def test_first_value_larger_than_25
    memory_grid = MemoryGrid.new
    assert_equal 26, memory_grid.first_value_larger_than(25)
  end

  def test_first_value_larger_than_360
    memory_grid = MemoryGrid.new
    assert_equal 362, memory_grid.first_value_larger_than(360)
  end
end
