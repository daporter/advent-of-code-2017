require 'minitest/autorun'
require_relative 'judge'

class JudgeTest < Minitest::Test
  def test_nth_pair_one
    judge = Judge.new(65, 8_921, 5)
    expected = %w[
      00000000000100001010101101100111
      00011001101010101101001100110111
    ]
    assert_equal expected, judge.nth_pair(1)
  end

  def test_nth_pair_two
    judge = Judge.new(65, 8_921, 5)
    expected = %w[
      01000110011001001111011100111001
      01001001100010001000010110001000
    ]
    assert_equal expected, judge.nth_pair(2)
  end

  def test_match_count_with_five_pairs
    judge = Judge.new(65, 8_921, 5)
    assert_equal 1, judge.match_count
  end

  def test_match_count_with_many_pairs
    judge = Judge.new(65, 8_921, 40_000_000)
    assert_equal 588, judge.match_count
  end
end
