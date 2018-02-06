class Particle
  Vector = Struct.new(:x, :y, :z) do
    def sum
      x.abs + y.abs + z.abs
    end
  end

  attr_reader :acceleration

  def self.parse(string)
    acceleration = parse_vector(:acceleration, string)
    new(acceleration)
  end

  def self.parse_vector(name, string)
    pattern = /#{name[0]}=<(-?\d+),(-?\d+),(-?\d+)>/
    unless (match = pattern.match(string))
      raise "Couldn't parse #{name}: #{string}"
    end
    Vector.new(match[1].to_i, match[2].to_i, match[3].to_i)
  end

  def initialize(acceleration)
    @acceleration = acceleration
  end

  def accel_sum
    acceleration.sum
  end
end
