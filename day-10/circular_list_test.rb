require 'minitest/autorun'
require_relative 'circular_list'

class CircularListTest < Minitest::Test
  def test_initialize_creates_elements
    list = CircularList.new(3)
    assert_equal [0, 1, 2], list.elements
  end

  def test_initialize_sets_current_position
    list = CircularList.new(3)
    assert_equal 0, list.current_position
  end

  def test_initialize_sets_skip_size
    list = CircularList.new(3)
    assert_equal 0, list.current_skip_size
  end

  def test_advance_current_position
    list = CircularList.new(3)
    list.advance_current_position(2)
    assert_equal 2, list.current_position
  end

  def test_advance_current_position_with_wrapping
    list = CircularList.new(3)
    list.advance_current_position(3)
    assert_equal 0, list.current_position
  end

  def test_advance_current_position_increments_skip_size
    list = CircularList.new(3)
    list.advance_current_position(1)
    assert_equal 1, list.current_skip_size
  end

  def test_reverse_elements_with_sublist_at_beginning
    list = CircularList.new(5)
    list.current_position = 0
    list.reverse_elements(3)
    assert_equal [2, 1, 0, 3, 4], list.elements
  end

  def test_reverse_elements_with_sublist_in_middle
    list = CircularList.new(5)
    list.current_position = 1
    list.reverse_elements(3)
    assert_equal [0, 3, 2, 1, 4], list.elements
  end

  def test_reverse_elements_with_sublist_at_end
    list = CircularList.new(5)
    list.current_position = 2
    list.reverse_elements(3)
    assert_equal [0, 1, 4, 3, 2], list.elements
  end

  def test_reverse_elements_with_sublist_wrapped
    list = CircularList.new(5)
    list.current_position = 3
    list.reverse_elements(3)
    assert_equal [3, 1, 2, 0, 4], list.elements
  end

  def test_take
    list = CircularList.new(3)
    assert_equal [0, 1], list.take(2)
  end
end
