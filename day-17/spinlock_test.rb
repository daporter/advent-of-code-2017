require 'minitest/autorun'
require_relative 'spinlock'

#
# Unit tests for class Spinlock.
#
class SpinlockTest < Minitest::Test
  def test_new
    spinlock = Spinlock.new(3)
    assert_equal [0], spinlock.values
  end

  def test_insert_one
    spinlock = Spinlock.new(3)
    spinlock.insert(1)
    assert_equal [1, 0], spinlock.values
  end

  def test_insert_two
    spinlock = Spinlock.new(3)
    spinlock.insert(2)
    assert_equal [2, 1, 0], spinlock.values
  end

  def test_insert_three
    spinlock = Spinlock.new(3)
    spinlock.insert(3)
    assert_equal [3, 1, 0, 2], spinlock.values
  end

  def test_insert_four
    spinlock = Spinlock.new(3)
    spinlock.insert(4)
    assert_equal [4, 3, 1, 0, 2], spinlock.values
  end

  def test_insert_five
    spinlock = Spinlock.new(3)
    spinlock.insert(5)
    assert_equal [5, 2, 4, 3, 1, 0], spinlock.values
  end

  def test_insert_2017
    spinlock = Spinlock.new(3)
    spinlock.insert(2017)
    assert_equal 638, spinlock.next_value
  end
end
