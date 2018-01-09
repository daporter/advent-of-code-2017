require 'minitest/autorun'
require_relative 'firewall'

class FirewallTest < Minitest::Test
  def setup
    @large_input = %(
      0: 3
      1: 2
      4: 4
      6: 4
    )
  end

  def test_from_string_with_empty_string
    fw = Firewall.from_string('')
    assert_empty fw.layers
  end

  def test_from_string_with_one_layer
    fw = Firewall.from_string('0: 3')
    assert_equal 3, fw.layer_range(0)
  end

  def test_from_string_with_two_layers
    input = %(
      0: 3
      1: 2
    )
    fw = Firewall.from_string(input)
    assert_equal 2, fw.layer_range(1)
  end

  def test_from_string_with_empty_layers
    fw = Firewall.from_string(@large_input)
    assert_equal 0, fw.layer_range(2)
    assert_equal 4, fw.layer_range(6)
  end

  def test_trip_severity_with_no_layers
    fw = Firewall.from_string('')
    assert_equal 0, fw.trip_severity
  end

  def test_trip_severity_with_one_layer
    fw = Firewall.from_string('0: 3')
    assert_equal 0, fw.trip_severity
  end

  def test_trip_severity_with_two_layers
    input = %(
      0: 3
      1: 2
    )
    fw = Firewall.from_string(input)
    assert_equal 0, fw.trip_severity
  end

  def test_trip_severity_with_multiple_layers
    fw = Firewall.from_string(@large_input)
    assert_equal 24, fw.trip_severity
  end
end
