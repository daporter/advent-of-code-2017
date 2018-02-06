require 'minitest/autorun'
require_relative 'particle'

class ParticleTest < Minitest::Test
  def test_parse
    string = 'p=<-3787,-3683,3352>, v=<41,-25,-124>, a=<5,9,1>'
    particle = Particle.parse(string)
    assert_equal 9, particle.acceleration.y
  end
end
