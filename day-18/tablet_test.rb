require 'minitest/autorun'
require_relative 'tablet'

class TabletTest < Minitest::Test
  def setup
    @code = %(
       set a 1
       add a 2
       mul a a
       mod a 5
       snd a
       set a 0
       rcv a
       jgz a -1
       set a 1
       jgz a -2
    )
  end

  def test_run_until_frequency_recovered
    tablet = Tablet.new(@code)
    assert_equal 4, tablet.run_until_frequency_recovered
  end
end
