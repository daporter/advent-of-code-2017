require_relative 'knot_hash'

#
# Represents a disk and tracks its block usage.
#
class Disk
  # 1. Data definitions, incl examples.
  # 2. Function header.
  # 3. Function examples and tests.
  # 4. Function template using data definitions.
  # 5. Complete function definition.
  # 6. Passing test cases.

  # A HashInput is a String.
  # Interpretation: The input string to the hash algorithm that represents row
  # of disk blocks.
  # Constraint: The string consists of a String + a dash + a number from 0-127,
  # where the number corresponds to the Grid row.
  # e.g. "flqrgnkx-127"

  # A Hash is a String.
  # Interpretation: A bit string that corresponds to a row in the grid and
  # indicates whether each square is free or not.
  # Constraint: Each character is a binary digit, and the string has length 128.
  # e.g. "10100000110000100000000101110000"

  # A Grid is a one-dimensional Array of Hashes.
  # Interpretation: Each row corresponds to a row of disk blocks and indicates
  # whether the blocks are free or used.
  # Constraint: The Grid has size 128.

  # A Square is a Binary-digit.
  # Interpretation: 1 indicates that a square is used, 0 that is is free.

  # The dimension of the grid that represents this Disk.
  GRID_DIMENSION = 128

  # Creates a new instance corresponding to the key string 'key'. The key is
  # used to construct a knot hash for each row of the Disk's grid that
  # represents whether each square in the row is free or used.
  def initialize(key)
    @grid = Array.new(GRID_DIMENSION)
    0.upto(GRID_DIMENSION - 1) { |row| @grid[row] = Disk.row_hash(row, key) }
  end

  # Returns a string representation of whether the square in row 'row_num' are
  # used or free.
  def row_to_s(row_num)
    row(row_num).chars.map { |num| num == '1' ? '#' : '.' }.join
  end

  # Returns the Hash corresponding to row number 'row_num' of this Disk's grid.
  # Raises an IndexError if 'row_num' is out of bounds.
  def row(row_num)
    raise IndexError if row_num < 0 || GRID_DIMENSION <= row_num
    @grid[row_num]
  end

  # Creates a Hash, using key 'key', corresponding to row 'row' of this Disk.
  def self.row_hash(row, key)
    # puts "* Creating hash for row #{key}-#{row}"
    hex = KnotHash.from_byte_string("#{key}-#{row}").dense_hash
    hex_to_binary(hex)
  end

  # Converts the hexadecimal string 'hex' to its binary string representation.
  def self.hex_to_binary(hex)
    hex.to_i(16).to_s(2)
  end

  # Counts the number of squares used.
  def squares_used_count
    (0..(GRID_DIMENSION - 1)).reduce(0) do |num_used, row|
      num_used + squares_used_in_row(row)
    end
  end

  # Counts the number of squares used in row 'row_num'.
  def squares_used_in_row(row_num)
    row(row_num).count('1')
  end
end
