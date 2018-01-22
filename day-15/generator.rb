#
# Generates a sequence of values according to a particular formula.
#
class Generator
  DIVISOR = 2_147_483_647

  def initialize(factor, starting_value, multiplier)
    @factor = factor
    @previous_value = starting_value
    @multiplier = multiplier
  end

  def nth_value(n)
    (0..n).reduce { next_value }
  end

  def nth_factored_value(n)
    (0..n).reduce { next_factored_value }
  end

  def next_factored_value
    loop do
      value = next_value
      return value if (value % @multiplier).zero?
    end
  end

  def next_value
    @previous_value = (@previous_value * @factor) % DIVISOR
  end
end
