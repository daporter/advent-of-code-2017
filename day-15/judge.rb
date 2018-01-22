require_relative 'generator'

#
# Judges the output of a pair of Generators.
#
class Judge
  def initialize(gen_a_start, gen_b_start, num_pairs)
    @num_pairs = num_pairs
    @generator_a = Generator.new(16_807, gen_a_start)
    @generator_b = Generator.new(48_271, gen_b_start)
  end

  def match_count
    pairs.count { |pair| Judge.matching_pair?(pair) }
  end

  def pairs
    (0..@num_pairs).map do
      [@generator_a.next_value, @generator_b.next_value]
    end
  end

  def self.matching_pair?(pair)
    rightmost_bits(pair[0]) == rightmost_bits(pair[1])
  end

  def self.rightmost_bits(value)
    value & 0xffff
  end

  def nth_pair(n)
    [@generator_a, @generator_b].map do |gen|
      Judge.format_value(gen.nth_value(n))
    end
  end

  def self.format_value(value)
    format('%032b', value)
  end
end
