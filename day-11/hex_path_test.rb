require 'minitest/autorun'
require_relative 'hex_path'

class HexPathTest < Minitest::Test
  def test_consective_complement_null_equivalent
    path = HexPath.from_string('s,se,nw,s')
    assert_equal [HexStep.s, HexStep.s], path.minimise.steps
  end

  def test_consective_complement_non_null_equivalent
    path = HexPath.from_string('s,se,sw,s')
    assert_equal [HexStep.s, HexStep.s, HexStep.s], path.minimise.steps
  end

  def test_non_consective_complement_non_null_equivalent
    path = HexPath.from_string('se,s,sw,nw')
    assert_equal [HexStep.s, HexStep.sw], path.minimise.steps
  end

  def test_no_complement
    path = HexPath.from_string('n,nw,n')
    assert_equal [HexStep.n, HexStep.nw, HexStep.n], path.minimise.steps
  end

  def test_three_steps
    path = HexPath.from_string('ne,ne,ne')
    assert_equal 3, path.minimise.step_count
  end

  def test_zero_steps
    path = HexPath.from_string('ne,ne,sw,sw')
    assert_equal 0, path.minimise.step_count
  end

  def test_two_steps
    path = HexPath.from_string('ne,ne,s,s')
    assert_equal 2, path.minimise.step_count
  end

  def test_three_steps_b
    path = HexPath.from_string('se,sw,se,sw,sw')
    assert_equal 3, path.minimise.step_count
  end
end
