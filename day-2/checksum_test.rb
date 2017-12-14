require 'minitest/autorun'
require_relative 'spreadsheet'

class ChecksumTest < Minitest::Test

  # The first row's largest and smallest values are 9 and 1, and their
  # difference is 8.
  def test_part_1_first_row
    spreadsheet = Spreadsheet.new('5 1 9 5')
    assert_equal 8, spreadsheet.checksum_differences
  end

  # The second row's largest and smallest values are 7 and 3, and their
  # difference is 4.
  def test_part_1_second_row
    spreadsheet = Spreadsheet.new('7 5 3')
    assert_equal 4, spreadsheet.checksum_differences
  end

  # The third row's difference is 6.
  def test_part_1_third_row
    spreadsheet = Spreadsheet.new('2 4 6 8')
    assert_equal 6, spreadsheet.checksum_differences
  end

  # In this example, the spreadsheet's checksum would be 8 + 4 + 6 = 18.
  def test_part_1_spreadsheet
    table = %(
    5 1 9 5
    7 5 3
    2 4 6 8
    )
    spreadsheet = Spreadsheet.new(table)
    assert_equal 18, spreadsheet.checksum_differences
  end

  # In the first row, the only two numbers that evenly divide are 8 and 2; the
  # result of this division is 4.
  def test_part_2_first_row
    spreadsheet = Spreadsheet.new('5 9 2 8')
    assert_equal 4, spreadsheet.checksum_quotients
  end

  # In the second row, the two numbers are 9 and 3; the result is 3.
  def test_part_2_second_row
    spreadsheet = Spreadsheet.new('9 4 7 3')
    assert_equal 3, spreadsheet.checksum_quotients
  end

  # In the third row, the result is 2.
  def test_part_2_third_row
    spreadsheet = Spreadsheet.new('3 8 6 5')
    assert_equal 2, spreadsheet.checksum_quotients
  end

  # In this example, the sum of the results would be 4 + 3 + 2 = 9.
  def test_part_2_spreadsheet
    table = %(
    5 9 2 8
    9 4 7 3
    3 8 6 5
    )
    spreadsheet = Spreadsheet.new(table)
    assert_equal 9, spreadsheet.checksum_quotients
  end
end
