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

  def test_garbage_chars_count_empty
    sp = StreamProcessor.new('<>')
    assert_equal 0, sp.garbage_chars_count
  end

  def test_garbage_chars_count_random_chars
    sp = StreamProcessor.new('<random characters>')
    assert_equal 17, sp.garbage_chars_count
  end

  def test_garbage_chars_count_chevrons
    sp = StreamProcessor.new('<<<<>')
    assert_equal 3, sp.garbage_chars_count
  end

  def test_garbage_chars_count_cancelled
    sp = StreamProcessor.new('<{!>}>')
    assert_equal 2, sp.garbage_chars_count
  end

  def test_garbage_chars_count_two_cancelled
    sp = StreamProcessor.new('<!!>')
    assert_equal 0, sp.garbage_chars_count
  end

  def test_garbage_chars_count_three_cancelled
    sp = StreamProcessor.new('<!!!>>')
    assert_equal 0, sp.garbage_chars_count
  end

  def test_garbage_chars_count_random
    sp = StreamProcessor.new('<{o"i!a,<{i<a>')
    assert_equal 10, sp.garbage_chars_count
  end
end
