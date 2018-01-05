require 'minitest/autorun'
require_relative 'hex_path'

class HexPathTest < Minitest::Test
  def test_minimised_path_add_step_without_complement
    path = HexPath.new(%i[n ne])
    assert_equal %i[n ne n], path.minimised_path_add_step(%i[n ne], :n)
  end

  def test_minimised_path_add_step_with_complement
    path = HexPath.new(%i[n ne])
    assert_equal %i[ne ne], path.minimised_path_add_step(%i[n ne], :se)
  end

  def test_path_contains_complement_without_complement
    path = %i[n ne]
    assert !HexPath.path_contains_complement?(path, :n)
  end

  def test_path_contains_complement_with_complement
    path = %i[n ne]
    assert HexPath.path_contains_complement?(path, :s)
  end

  def test_path_remove_complement
    path, = HexPath.path_remove_complement(%i[n n], :s)
    assert_equal %i[n], path
  end

  def test_complementary_true
    assert HexPath.complementary?(:n, :s)
  end

  def test_complementary_false
    assert !HexPath.complementary?(:n, :n)
  end

  def test_reduce_steps_null_reduction
    assert_nil HexPath.reduce_steps(:n, :s)
  end

  def test_reduce_steps_step_reduction
    assert :ne, HexPath.reduce_steps(:n, :se)
  end

  def test_reduce_steps_raises_exception
    assert_raises(ArgumentError) { HexPath.reduce_steps(:n, :n) }
  end

  def test_consective_complement_null_equivalent
    path = HexPath.from_string('s,se,nw,s')
    assert_equal %i[s s], path.minimise.steps
  end

  def test_consective_complement_non_null_equivalent
    path = HexPath.from_string('s,se,sw,s')
    assert_equal %i[s s s], path.minimise.steps
  end

  def test_non_consective_complement_non_null_equivalent
    path = HexPath.from_string('se,s,sw,nw')
    assert_equal %i[s sw], path.minimise.steps
  end

  def test_no_complement
    path = HexPath.from_string('n,nw,n')
    assert_equal %i[n nw n], path.minimise.steps
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

  def test_furthest_from_start_no_steps
    path = HexPath.from_string('')
    assert_equal 0, path.furthest_from_start
  end

  def test_furthest_from_start_one_step
    path = HexPath.from_string('n')
    assert_equal 1, path.furthest_from_start
  end

  def test_furthest_from_start_one_reduction
    path = HexPath.from_string('n,n,s,n')
    assert_equal 2, path.furthest_from_start
  end

  def test_furthest_from_start_two_reduction
    path = HexPath.from_string('n,n,se,nw')
    assert_equal 2, path.furthest_from_start
  end
end
