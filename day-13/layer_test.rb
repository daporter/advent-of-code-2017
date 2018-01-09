require 'minitest/autorun'
require_relative 'layer'

#
# Unit tests for the Layer class.
#
class LayerTest < Minitest::Test
  def test_severity_with_zero_depth
    assert_equal 0, Layer.new(0, 3).severity
  end

  def test_severity_with_non_zero_depth
    assert_equal 24, Layer.new(6, 4).severity
  end
end
