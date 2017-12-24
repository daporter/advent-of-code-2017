require 'minitest/autorun'
require_relative 'cpu'

class CpuTest < Minitest::Test
  # For example, consider the following list of jump offsets: 0 3 0 1 -3
  #
  # (0) 3 0 1 -3
  # - before we have taken any steps.
  def test_simple_jump_initial_state
    cpu = SimpleCpu.new([0, 3, 0, 1, -3])
    assert_equal 0, cpu.program_counter
  end

  # (1) 3 0 1 -3
  # - jump with offset 0 (that is, don't jump at
  #   all). Fortunately, the instruction is then incremented to 1.
  def test_simple_jump_offset_zero
    cpu = SimpleCpu.new([0, 3, 0, 1, -3])
    cpu.step
    assert_equal 0, cpu.program_counter
    assert_equal 1, cpu.instructions[0]
  end

  # 2 (3) 0 1 -3
  # - step forward because of the instruction we just
  #   modified. The first instruction is incremented again, now to 2.
  def test_simple_jump_offset_one
    cpu = SimpleCpu.new([0, 3, 0, 1, -3])
    2.times { cpu.step }
    assert_equal 1, cpu.program_counter
    assert_equal 2, cpu.instructions[0]
  end

  # 2 4 0 1 (-3)
  # - jump all the way to the end; leave a 4 behind.
  def test_simple_jump_offset_three
    cpu = SimpleCpu.new([0, 3, 0, 1, -3])
    3.times { cpu.step }
    assert_equal 4, cpu.program_counter
    assert_equal 4, cpu.instructions[1]
  end

  # 2 (4) 0 1 -2
  # - go back to where we just were; increment -3 to -2.
  def test_simple_jump_offset_minus_three
    cpu = SimpleCpu.new([0, 3, 0, 1, -3])
    4.times { cpu.step }
    assert_equal 1, cpu.program_counter
    assert_equal -2, cpu.instructions[4]
  end

  # 2 5 0 1 -2
  # - jump 4 steps forward, escaping the maze.
  def test_simple_jump_offset_four
    cpu = SimpleCpu.new([0, 3, 0, 1, -3])
    5.times { cpu.step }
    assert cpu.complete?
    assert_equal 5, cpu.instructions[1]
  end

  # Now, the jumps are even stranger: after each jump, if the offset was three
  # or more, instead decrease it by 1. Otherwise, increase it by 1 as before.
  #
  # Using this rule with the above example, the process now takes 10 steps,
  # and the offset values after finding the exit are left as 2 3 2 3 -1.
  def test_complex_jump_step_0
    cpu = ComplexCpu.new([0, 3, 0, 1, -3])
    cpu.execute
    assert_equal 10, cpu.steps
    assert_equal [2, 3, 2, 3, -1], cpu.instructions
  end
end
