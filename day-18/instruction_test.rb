require 'minitest/autorun'
require_relative 'instruction'

class InstructionTest < Minitest::Test
  def test_set
    registers = { a: 0 }
    set = SetInstruction.new(:a, 1)
    registers = set.execute(registers)
    assert_equal 1, registers[:a]
  end

  def test_add
    registers = { a: 0 }
    add = AddInstruction.new(:a, 2)
    registers = add.execute(registers)
    assert_equal 2, registers[:a]
  end

  def test_mul
    registers = { a: 2, b: 3 }
    mul = MulInstruction.new(:a, :b)
    registers = mul.execute(registers)
    assert_equal 6, registers[:a]
  end

  def test_mod
    registers = { a: 7 }
    mod = ModInstruction.new(:a, 4)
    registers = mod.execute(registers)
    assert_equal 3, registers[:a]
  end

  def test_snd_adds_value_to_queue
    send_queue = []
    registers = { snd: send_queue, send_count: 0 }
    snd = SndInstruction.new(1)
    snd.execute(registers)
    assert_equal [1], send_queue
  end

  def test_rcv_does_nothing_when_queue_empty
    receive_queue = []
    registers = { a: 2, rcv: receive_queue, pc: 1 }
    rcv = RcvInstruction.new(:a)
    registers = rcv.execute(registers)
    assert_equal 2, registers[:a]
    assert_equal 0, registers[:pc]
  end

  def test_rcv_consumes_value_when_queue_nonempty
    receive_queue = [3]
    registers = { a: 2, rcv: receive_queue }
    rcv = RcvInstruction.new(:a)
    registers = rcv.execute(registers)
    assert_equal 3, registers[:a]
  end

  def test_jgz_when_x_le_zero
    registers = { a: 0, pc: 1 }
    jgz = JgzInstruction.new(:a, 2)
    registers = jgz.execute(registers)
    assert_equal 1, registers[:pc]
  end

  def test_jgz_when_x_gt_zero
    registers = { a: 1, pc: 1 }
    jgz = JgzInstruction.new(:a, 2)
    registers = jgz.execute(registers)
    assert_equal 2, registers[:pc]
  end
end
