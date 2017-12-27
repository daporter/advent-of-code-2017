require 'minitest/autorun'
require_relative 'cpu'

class CpuTest < Minitest::Test
  def setup
    @text = %(
      b inc 5 if a > 1
      a inc 1 if b < 5
      c dec -10 if a >= 1
      c inc -20 if c == 10
    )
  end

  def test_execute_one_instruction
    cpu = Cpu.new(@text)
    cpu.execute_next_instruction
    assert_equal 0, cpu.get_register_value('a')
    assert_equal 0, cpu.get_register_value('b')
  end

  def test_execute_two_instructions
    cpu = Cpu.new(@text)
    2.times { cpu.execute_next_instruction }
    assert_equal 1, cpu.get_register_value('a')
    assert_equal 0, cpu.get_register_value('b')
  end

  def test_execute_three_instructions
    cpu = Cpu.new(@text)
    3.times { cpu.execute_next_instruction }
    assert_equal 1, cpu.get_register_value('a')
    assert_equal 10, cpu.get_register_value('c')
  end

  def test_execute_three_instructions
    cpu = Cpu.new(@text)
    4.times { cpu.execute_next_instruction }
    assert_equal (-10), cpu.get_register_value('c')
  end

  def test_largest_value_in_any_register
    cpu = Cpu.new(@text)
    cpu.execute
    assert_equal 1, cpu.largest_value_in_any_register
  end
end
