require 'minitest/autorun'
require_relative 'spreadsheet'

class ChecksumTest < Minitest::Test

  # The first row's largest and smallest values are 9 and 1, and their
  # difference is 8.
  def test_first_row
    spreadsheet = Spreadsheet.new('5 1 9 5')
    assert_equal 8, spreadsheet.checksum
  end

  # The second row's largest and smallest values are 7 and 3, and their
  # difference is 4.
  def test_second_row
    spreadsheet = Spreadsheet.new('7 5 3')
    assert_equal 4, spreadsheet.checksum
  end

  # The third row's difference is 6.
  def test_third_row
    spreadsheet = Spreadsheet.new('2 4 6 8')
    assert_equal 6, spreadsheet.checksum
  end

  # In this example, the spreadsheet's checksum would be 8 + 4 + 6 = 18.
  def test_spreadsheet
    table = %q(
    5 1 9 5
    7 5 3
    2 4 6 8
    )
    spreadsheet = Spreadsheet.new(table)
    assert_equal 18, spreadsheet.checksum
  end
end
