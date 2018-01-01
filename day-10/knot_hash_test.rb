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

  def test_execute_round
    hash = KnotHash.new(5, [3, 4, 1, 5])
    hash.execute_round
    assert_equal [3, 4, 2, 1, 0], hash.list
  end

  def test_initialize_from_string
    hash = KnotHash.from_byte_string('1,2,3')
    expected = [49, 44, 50, 44, 51, 17, 31, 73, 47, 23]
    assert_equal expected, hash.initial_input_lengths
  end

  def test_dense_hash_with_empty_string
    hash = KnotHash.from_byte_string('')
    hash.execute
    assert_equal 'a2582a3a0e66e6e86e3812dcb672a272', hash.dense_hash
  end

  def test_dense_hash_with_string_one
    hash = KnotHash.from_byte_string('AoC 2017')
    hash.execute
    assert_equal '33efeb34ea91902bb2f59c9920caa6cd', hash.dense_hash
  end

  def test_dense_hash_with_string_two
    hash = KnotHash.from_byte_string('1,2,3')
    hash.execute
    assert_equal '3efbe78a8d82f29979031a4aa0b16a9d', hash.dense_hash
  end

  def test_dense_hash_with_string_three
    hash = KnotHash.from_byte_string('1,2,4')
    hash.execute
    assert_equal '63960835bcdc130f0b66d7ff4f6a5a8e', hash.dense_hash
  end
end
