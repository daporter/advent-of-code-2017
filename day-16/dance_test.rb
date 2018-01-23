require 'minitest/autorun'
require_relative 'dance'

class DanceTest < Minitest::Test
  def test_perform
    line = %i[a b c d e]
    dance = Dance.parse('s1,x3/4,pe/b')
    assert_equal %i[b a e d c], dance.perform(line)
  end

  def test_perform_n
    line = %i[a b c d e]
    dance = Dance.parse('s1,x3/4,pe/b')
    assert_equal %i[c e a d b], dance.perform_n(2, line)
  end
end
