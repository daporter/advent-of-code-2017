require_relative 'particle'

class Gpu
  def self.parse(string)
    particles = string.strip.lines.map { |line| Particle.parse(line) }
    new(particles)
  end

  def initialize(particles)
    @particles = particles
  end

  def closest_particle_num
    accel_sums = @particles.map(&:accel_sum)
    accel_sums.index(accel_sums.min)
  end
end
