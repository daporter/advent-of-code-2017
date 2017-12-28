require 'minitest/autorun'
require_relative 'stream_processor'

#
# Tests for the StreamProcessor class.
#
class StreamProcessorTest < Minitest::Test
  def test_one_group
    sp = StreamProcessor.new('{}')
    assert_equal 1, sp.score
  end

  def test_three_groups_a
    sp = StreamProcessor.new('{{{}}}')
    assert_equal 6, sp.score
  end

  def test_three_groups_b
    sp = StreamProcessor.new('{{},{}}')
    assert_equal 5, sp.score
  end

  def test_six_groups
    sp = StreamProcessor.new('{{{},{},{{}}}}')
    assert_equal 16, sp.score
  end

  def test_garbage_in_group
    sp = StreamProcessor.new('{<a>,<a>,<a>,<a>}')
    assert_equal 1, sp.score
  end

  def test_garbage_in_groups_a
    sp = StreamProcessor.new('{{<ab>},{<ab>},{<ab>},{<ab>}}')
    assert_equal 9, sp.score
  end

  def test_score_consecutive_cancels
    sp = StreamProcessor.new('{{<!!>},{<!!>},{<!!>},{<!!>}}')
    assert_equal 9, sp.score
  end

  def test_some_cancels
    sp = StreamProcessor.new('{{<a!>},{<a!>},{<a!>},{<ab>}}')
    assert_equal 3, sp.score
  end
end
