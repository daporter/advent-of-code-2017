require 'minitest/autorun'
require_relative 'digital_plumber'

#
# Tests for the DigitalPlumber class.
#
class DigitalPlumberTest < Minitest::Test
  def test_program_group_with_one_pipe_set
    plumber = DigitalPlumber.pipe_sets_from_string('0 <-> 2')
    assert_equal [0, 2], plumber.program_group(0)
  end

  def test_program_group_with_one_pipe_set_many_pipes
    plumber = DigitalPlumber.pipe_sets_from_string('2 <-> 0, 3, 4')
    assert_equal [0, 2, 3, 4], plumber.program_group(2)
  end

  def test_program_group_with_two_pipe_sets
    input = %(
      0 <-> 2
      2 <-> 3
    )
    plumber = DigitalPlumber.pipe_sets_from_string(input)
    assert_equal [0, 2, 3], plumber.program_group(0)
  end

  def test_program_group_with_pipe_sets_containing_loop
    input = %(
      0 <-> 2
      2 <-> 0
      )
    plumber = DigitalPlumber.pipe_sets_from_string(input)
    assert_equal [0, 2], plumber.program_group(0)
  end

  def test_program_group_with_multiple_pipe_sets
    input = %(
      0 <-> 2
      2 <-> 0, 3
      3 <-> 2
      )
    plumber = DigitalPlumber.pipe_sets_from_string(input)
    assert_equal [0, 2, 3], plumber.program_group(0)
  end

  def test_program_group_with_with_many_pipe_sets
    input = %(
      0 <-> 2
      1 <-> 1
      2 <-> 0, 3, 4
      3 <-> 2, 4
      4 <-> 2, 3, 6
      5 <-> 6
      6 <-> 4, 5
    )
    plumber = DigitalPlumber.pipe_sets_from_string(input)
    assert_equal [0, 2, 3, 4, 5, 6], plumber.program_group(0)
  end
end
