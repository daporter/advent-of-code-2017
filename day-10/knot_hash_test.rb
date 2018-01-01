require 'minitest/autorun'
require_relative 'knot_hash'

class KnotHashTest < Minitest::Test
  def test_step_one
    hash = KnotHash.new(5, [3, 4, 1, 5])
    hash.step
    assert_equal [2, 1, 0, 3, 4], hash.list
  end

  def test_step_two
    hash = KnotHash.new(5, [3, 4, 1, 5])
    2.times { hash.step }
    assert_equal [4, 3, 0, 1, 2], hash.list
  end

  def test_step_three
    hash = KnotHash.new(5, [3, 4, 1, 5])
    3.times { hash.step }
    assert_equal [4, 3, 0, 1, 2], hash.list
  end

  def test_step_four
    hash = KnotHash.new(5, [3, 4, 1, 5])
    4.times { hash.step }
    assert_equal [3, 4, 2, 1, 0], hash.list
  end

  def test_execute
    hash = KnotHash.new(5, [3, 4, 1, 5])
    hash.execute
    assert_equal [3, 4, 2, 1, 0], hash.list
  end
end
