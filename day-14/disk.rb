require_relative 'knot_hash'

#
# Represents a disk and tracks its block usage.
#
class Disk
  # The dimension of the grid that represents this Disk.
  GRID_DIMENSION = 128

  attr_reader :grid

  # Creates a new instance corresponding to the key string 'key'. The key is
  # used to construct a knot hash for each row of the Disk's grid that
  # represents whether each square in the row is free or used.
  def initialize(key)
    bit_strings = Disk.bit_strings_from_key(key)
    @grid = Disk.bit_strings_to_squares(bit_strings)
  end

  def self.bit_strings_from_key(key)
    (0..(GRID_DIMENSION - 1)).map { |row| row_hash(row, key) }
  end

  # Returns a grid of squares corresponding to 'bit_strings'. Each square
  # indicates whether it's free or used, and if used, which which region it
  # belongs to.
  def self.bit_strings_to_squares(bit_strings)
    grid = Array.new(GRID_DIMENSION) { Array.new(GRID_DIMENSION) }
    region = 1
    bit_strings.size.times do |row|
      bit_strings[row].length.times do |col|
        bit = bit_strings[row][col]
        square = grid[row][col]
        if bit.nil? || bit == '0'
          grid[row][col] = 0
        elsif square.nil? || square > region
          # We have a new region so mark all adjacent squares with 'region'.  We
          # don't have to consider the squares above or to the left, since they
          # have already been processed.
          grid[row][col] = region
          mark_adjacent_squares_right(bit_strings, row, col + 1, grid, region)
          mark_adjacent_squares_down(bit_strings, row + 1, col, grid, region)
          region += 1
        end
      end
    end
    grid
  end

  def self.mark_adjacent_squares_right(bit_strings, row, col, grid, region)
    return grid if bit_strings[row].length - 1 < col
    if bit_free?(bit_strings, row, col)
      grid[row][col] = 0
    elsif no_region?(grid, row, col)
      grid[row][col] = region
      mark_adjacent_squares_up(bit_strings, row - 1, col, grid, region)
      mark_adjacent_squares_right(bit_strings, row, col + 1, grid, region)
      mark_adjacent_squares_down(bit_strings, row + 1, col, grid, region)
    end
    grid
  end

  def self.mark_adjacent_squares_down(bit_strings, row, col, grid, region)
    return grid if bit_strings.length - 1 < row
    if bit_free?(bit_strings, row, col)
      grid[row][col] = 0
    elsif no_region?(grid, row, col)
      grid[row][col] = region
      mark_adjacent_squares_left(bit_strings, row, col - 1, grid, region)
      mark_adjacent_squares_down(bit_strings, row + 1, col, grid, region)
      mark_adjacent_squares_right(bit_strings, row, col + 1, grid, region)
    end
    grid
  end

  def self.mark_adjacent_squares_left(bit_strings, row, col, grid, region)
    return grid if col < 0
    if bit_free?(bit_strings, row, col)
      grid[row][col] = 0
    elsif no_region?(grid, row, col)
      grid[row][col] = region
      mark_adjacent_squares_up(bit_strings, row - 1, col, grid, region)
      mark_adjacent_squares_left(bit_strings, row, col - 1, grid, region)
      mark_adjacent_squares_down(bit_strings, row + 1, col, grid, region)
    end
    grid
  end

  def self.mark_adjacent_squares_up(bit_strings, row, col, grid, region)
    return grid if row < 0
    if bit_free?(bit_strings, row, col)
      grid[row][col] = 0
    elsif no_region?(grid, row, col)
      grid[row][col] = region
      mark_adjacent_squares_left(bit_strings, row, col - 1, grid, region)
      mark_adjacent_squares_up(bit_strings, row - 1, col, grid, region)
      mark_adjacent_squares_right(bit_strings, row, col + 1, grid, region)
    end
    grid
  end

  def self.no_region?(grid, row, col)
    !grid[row][col]
  end

  def self.bit_free?(bit_strings, row, col)
    bit_strings[row][col] == '0'
  end

  # Returns a string representation of whether the square in row 'row_num' are
  # used or free.
  def row_to_s(row_num)
    row(row_num).map { |square| Disk.square_used?(square) ? '#' : '.' }.join
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
  def self.hex_to_binary(hex_s)
    format('%0128b', hex_s.hex)
  end

  # Counts the number of squares used.
  def squares_used_count
    (0..(GRID_DIMENSION - 1)).reduce(0) do |num_used, row|
      num_used + squares_used_in_row(row)
    end
  end

  # Counts the number of squares used in row 'row_num'.
  def squares_used_in_row(row_num)
    row(row_num).count { |square| Disk.square_used?(square) }
  end

  # Counts the number of regions present in this Disk's grid. A region is a
  # group of used squares that are all adjacent, not including diagonals.
  def count_regions
    # Since each square is represented by it's region number, or 0 if it is
    # unused, finding the number of regions in the grid is equivalent to finding
    # the maximum region number in the grid.
    @grid.reduce(0) { |max_region_num, row| [max_region_num, row.max].max }
  end

  def self.square_free?(square)
    square.zero?
  end

  def self.square_used?(square)
    !square_free?(square)
  end
end
