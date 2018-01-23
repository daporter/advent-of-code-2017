require 'minitest/autorun'
require_relative 'move'

#
# Unit tests for class Move.
#
class MoveTest < Minitest::Test
  def test_spin
    move = Move.parse('s1')
    assert_equal %i[e a b c d], move.perform(%i[a b c d e])
  end

  def test_exchange
    move = Move.parse('x3/4')
    assert_equal %i[e a b d c], move.perform(%i[e a b c d])
  end

  def test_partner
    move = Move.parse('pe/b')
    assert_equal %i[b a e d c], move.perform(%i[e a b d c])
  end
end
