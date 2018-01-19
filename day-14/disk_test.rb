require 'minitest/autorun'
require_relative 'disk'
require_relative 'knot_hash'

#
# Unit tests for class Disk.
#
class DiskTest < Minitest::Test
  def setup
    @key = 'flqrgnkx'
  end

  def test_row_num_raises_error
    disk = Disk.new(@key)
    assert_raises(IndexError) { disk.row(128) }
  end

  def test_row_to_s_row_zero
    disk = Disk.new(@key)
    assert_equal '##.#.#..', disk.row_to_s(0).slice(0, 8)
  end

  def test_row_to_s_row_seven
    disk = Disk.new(@key)
    assert_equal '##.#.##.', disk.row_to_s(7).slice(0, 8)
  end

  def test_squares_used_count
    disk = Disk.new(@key)
    assert_equal 8108, disk.squares_used_count
  end

  def test_bit_strings_to_squares_with_one_zero
    assert_equal [0], Disk.bit_strings_to_squares(['0'])[0].take(1)
  end

  def test_bit_strings_to_squares_with_one_one
    assert_equal [1], Disk.bit_strings_to_squares(['1'])[0].take(1)
  end

  def test_bit_strings_to_squares_with_one_region
    assert_equal [[1, 0], [1, 0]], Disk.bit_strings_to_squares(['10', '10']).take(2).map { |row| row.take(2) }
  end

  def test_bit_strings_to_squares_with_two_regions
    assert_equal [[1, 0], [0, 2]], Disk.bit_strings_to_squares(['10', '01']).take(2).map { |row| row.take(2) }
  end

  def test_bit_strings_to_squares_with_two_regions_complex
    bit_strings = ['101', '011', '000']
    expected = [[1, 0, 2], [0, 2, 2], [0, 0, 0]]
    assert_equal expected, Disk.bit_strings_to_squares(bit_strings).take(3).map { |row| row.take(3) }
  end

  def test_count_regions
    disk = Disk.new(@key)
    assert_equal 1242, disk.count_regions
  end
end
