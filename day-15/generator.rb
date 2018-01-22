#
# Generates a sequence of values according to a particular formula.
#
class Generator
  DIVISOR = 2_147_483_647

  def initialize(factor, starting_value)
    @factor = factor
    @previous_value = starting_value
  end

  def nth_value(n)
    (0..n).reduce { |_, _| next_value }
  end

  def next_value
    value = (@previous_value * @factor) % DIVISOR
    @previous_value = value
    value
  end
end
