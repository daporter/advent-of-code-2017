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

  def test_snd
    registers = { a: 4 }
    snd = SndInstruction.new(:a)
    registers = snd.execute(registers)
    assert_equal 4, registers[:snd]
  end

  def test_rcv_when_zero
    registers = { a: 0, rcv: 0 }
    rcv = RcvInstruction.new(:a)
    registers = rcv.execute(registers)
    assert_equal 0, registers[:rcv]
  end

  def test_rcv_when_non_zero
    registers = { a: 1, snd: 4, rcv: 0 }
    rcv = RcvInstruction.new(:a)
    registers = rcv.execute(registers)
    assert_equal 4, registers[:rcv]
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
