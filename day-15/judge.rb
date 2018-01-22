require_relative 'generator'

#
# Judges the output of a pair of Generators.
#
class Judge
  GENERATOR_A_FACTOR = 16_807
  GENERATOR_A_MULT = 4
  GENERATOR_B_FACTOR = 48_271
  GENERATOR_B_MULT = 8

  def initialize(gen_a_start, gen_b_start, num_pairs)
    @num_pairs = num_pairs
    @generator_a = Generator.new(GENERATOR_A_FACTOR,
                                 gen_a_start, GENERATOR_A_MULT)
    @generator_b = Generator.new(GENERATOR_B_FACTOR,
                                 gen_b_start, GENERATOR_B_MULT)
  end

  def match_count
    pairs.count { |pair| Judge.matching_pair?(pair) }
  end

  def factored_match_count
    factored_pairs.count { |pair| Judge.matching_pair?(pair) }
  end

  def pairs
    (0..@num_pairs).map do
      [@generator_a.next_value, @generator_b.next_value]
    end
  end

  def factored_pairs
    (0..@num_pairs).map do
      [@generator_a.next_factored_value,
       @generator_b.next_factored_value]
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
