require_relative 'circular_list'

#
# Implements a software emulation of a hash based on knot-tying.
#
class KnotHash
  # Returns a new KnotHash that uses a circular list of length 'list_length'
  # and the given list of input lengths.
  def initialize(list_length, input_lengths)
    @circular_list = CircularList.new(list_length)
    @input_lengths = input_lengths
  end

  # Executes the knot-hash algorithm.
  def execute
    step until @input_lengths.empty?
  end

  # Executes a single step of the knot-hash algorithm.
  def step
    length = @input_lengths.shift
    @circular_list.reverse_elements(length)
  end

  # Returns the current list of numbers.
  def list
    @circular_list.elements
  end
end
