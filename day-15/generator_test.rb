require 'minitest/autorun'
require_relative 'generator'

#
# Unit tests for class Generator.
#
class GeneratorTest < Minitest::Test
  def test_nth_value_one
    gen_a = Generator.new(16_807, 65)
    assert_equal 1_092_455, gen_a.nth_value(1)
  end

  def test_nth_value_two
    gen_a = Generator.new(16_807, 65)
    assert_equal 1_181_022_009, gen_a.nth_value(2)
  end

  def test_nth_value_three
    gen_a = Generator.new(16_807, 65)
    assert_equal 245_556_042, gen_a.nth_value(3)
  end

  def test_nth_value_four
    gen_a = Generator.new(16_807, 65)
    assert_equal 1_744_312_007, gen_a.nth_value(4)
  end

  def test_nth_value_five
    gen_a = Generator.new(16_807, 65)
    assert_equal 1_352_636_452, gen_a.nth_value(5)
  end
end
