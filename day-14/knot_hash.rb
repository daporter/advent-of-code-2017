require_relative 'circular_list'

#
# Implements a software emulation of a hash based on knot-tying.
#
class KnotHash
  # The standard length of the list of numbers used in the Knot Hash
  # algorithm.
  STANDARD_LIST_LENGTH = 256

  # The standard list of values to be appended to the list of input lengths.
  STANDARD_LENGTHS_SUFFIX = [17, 31, 73, 47, 23].freeze

  attr_reader :initial_input_lengths

  # Returns a new KnotHash constructed from the string of bytes 'byte_string'.
  def self.from_byte_string(byte_string)
    input_lengths = KnotHash.byte_string_to_numbers(byte_string)
    input_lengths += STANDARD_LENGTHS_SUFFIX
    new(STANDARD_LIST_LENGTH, input_lengths)
  end

  # Returns a new KnotHash that uses a circular list of length 'list_length'
  # and the given list of initial input lengths.
  def initialize(list_length, initial_input_lengths)
    @circular_list = CircularList.new(list_length)
    @initial_input_lengths = initial_input_lengths
    @input_lengths = initial_input_lengths.dup
  end

  # Executes 64 rounds of the Knot Hash algorithm. Uses the same length
  # sequence in each round and preserves the current position and skip size
  # between rounds.
  def execute
    64.times do
      execute_round
      @input_lengths = @initial_input_lengths.dup
    end
  end

  # Executes a single round of the Knot Hash algorithm.
  def execute_round
    step until @input_lengths.empty?
  end

  # Executes a single step of the Knot Hash algorithm.
  def step
    length = @input_lengths.shift
    @circular_list.reverse_elements(length)
  end

  # Returns the current list of numbers.
  def list
    @circular_list.elements
  end

  alias sparse_hash list

  # Computes the dense hash of the current list of numbers and returns its
  # hexadecimal string representation.
  def dense_hash
    execute
    blocks_of_16 = sparse_hash.each_slice(16).to_a
    hash = blocks_of_16.map { |block| block.reduce(:^) }
    hash.reduce('') { |hex_str, number| hex_str << format('%02x', number) }
  end

  # Convert each character in 'byte_string' to its ASCII code.
  def self.byte_string_to_numbers(byte_string)
    byte_string.unpack('C*')
  end
end
