require 'minitest/autorun'
require_relative 'memory_reallocator'

class MemoryReallocatorTest < Minitest::Test
  # The banks start with 0, 2, 7, and 0 blocks. The third bank has the most
  # blocks, so it is chosen for redistribution.
  #
  # Starting with the next bank (the fourth bank) and then continuing to the
  # first bank, the second bank, and so on, the 7 blocks are spread out over
  # the memory banks. The fourth, first, and second banks get two blocks each,
  # and the third bank gets one back. The final result looks like this: 2 4 1
  # 2.
  def test_step_one
    mr = MemoryReallocator.new([0, 2, 7, 0])
    mr.perform_cycle
    assert_equal [2, 4, 1, 2], mr.banks
  end

  # Next, the second bank is chosen because it contains the most blocks
  # (four). Because there are four memory banks, each gets one block. The
  # result is: 3 1 2 3.
  def test_step_two
    mr = MemoryReallocator.new([2, 4, 1, 2])
    mr.perform_cycle
    assert_equal [3, 1, 2, 3], mr.banks
  end

  # Now, there is a tie between the first and fourth memory banks, both of
  # which have three blocks. The first bank wins the tie, and its three blocks
  # are distributed evenly over the other three banks, leaving it with none: 0
  # 2 3 4.
  def test_step_three
    mr = MemoryReallocator.new([3, 1, 2, 3])
    mr.perform_cycle
    assert_equal [0, 2, 3, 4], mr.banks
  end

  # The fourth bank is chosen, and its four blocks are distributed such that
  # each of the four banks receives one: 1 3 4 1.
  def test_step_four
    mr = MemoryReallocator.new([0, 2, 3, 4])
    mr.perform_cycle
    assert_equal [1, 3, 4, 1], mr.banks
  end

  # - The third bank is chosen, and the same thing happens: 2 4 1 2.
  def test_step_five
    mr = MemoryReallocator.new([1, 3, 4, 1])
    mr.perform_cycle
    assert_equal [2, 4, 1, 2], mr.banks
  end

  # At this point, we've reached a state we've seen before: 2 4 1 2 was
  # already seen. The infinite loop is detected after the fifth block
  # redistribution cycle, and so the answer in this example is 5.
  def test_cycles_until_loop_detected
    mr = MemoryReallocator.new([0, 2, 7, 0])
    assert_equal 5, mr.cycles_until_loop_detected
  end
end
