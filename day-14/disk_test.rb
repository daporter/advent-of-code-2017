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

  def test_initialize_first_row
    disk = Disk.new(@key)
    hash = KnotHash.from_byte_string("#{@key}-0").dense_hash
    assert_equal Disk.hex_to_binary(hash), disk.row(0)
  end

  def test_initialize_last_row
    disk = Disk.new(@key)
    hash = KnotHash.from_byte_string("#{@key}-127").dense_hash
    assert_equal Disk.hex_to_binary(hash), disk.row(127)
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
end
