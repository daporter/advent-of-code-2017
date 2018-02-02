#
# The network routing diagram.
#
class Diagram
  PATH_VERT    = '|'.freeze
  PATH_HORIZ   = '-'.freeze
  PATH_CORNER  = '+'.freeze
  PATH_LETTERS = ('A'..'Z').to_a.freeze
  PATH_CHARS   = [PATH_VERT, PATH_HORIZ, PATH_CORNER] + PATH_LETTERS

  attr_accessor :prev_posn
  attr_accessor :packet_posn
  attr_reader :letters_seen

  # Create a new diagram from a string representation.
  def self.parse(string)
    grid = string.split("\n").map { |line| parse_row(line) }
    new(grid)
  end

  # Create a row in the diagram from a string representation.
  def self.parse_row(string)
    string.chars
  end

  def initialize(grid)
    @grid         = grid
    @prev_posn    = nil
    @packet_posn  = starting_position
    @letters_seen = ''
  end

  # Find the starting position in the diagram. The starting position is '|' in
  # the first row.
  def starting_position
    row = 0
    column = @grid[row].find_index(PATH_VERT)
    Position.new(row, column)
  end

  def move_packet_along_path
    loop do
      next_step_along_path
      maybe_update_letters_seen
      break if end_of_path_reached?
    end
  end

  def next_step_along_path
    tmp = @packet_posn
    @packet_posn = if grid_character(@packet_posn) == PATH_CORNER
                     next_step_around_corner
                   else
                     @packet_posn.next_straight_line(@prev_posn)
                   end
    @prev_posn = tmp
  end

  def maybe_update_letters_seen
    char = grid_character(@packet_posn)
    @letters_seen << char if PATH_LETTERS.include?(char)
  end

  def end_of_path_reached?
    posns = @packet_posn.surrounding_positions
    posns.delete(@prev_posn)
    posns.none? { |posn| on_path?(posn) }
  end

  # Determine the next step along the path in the diagram when the current
  # position is a corner.
  def next_step_around_corner
    if @packet_posn.vertical_to?(@prev_posn)
      next_step_horizontally
    else
      next_step_vertically
    end
  end

  def next_step_horizontally
    next_posn = @packet_posn.next_right
    on_path?(next_posn) ? next_posn : @packet_posn.next_left
  end

  def next_step_vertically
    next_posn = @packet_posn.next_below
    on_path?(next_posn) ? next_posn : @packet_posn.next_above
  end

  def on_path?(posn)
    row = posn.row
    col = posn.column
    row >= 0 && row < height && col >= 0 && col < @grid[row].length &&
      PATH_CHARS.include?(grid_character(posn))
  end

  # Get the character at the specified position in the diagram.
  def grid_character(posn)
    @grid[posn.row][posn.column]
  end

  def height
    @grid.size
  end

  #
  # A position in the diagram.
  #
  class Position
    attr_reader :row
    attr_reader :column

    def initialize(row, column)
      @row = row
      @column = column
    end

    def next_straight_line(prev_posn)
      return next_below unless prev_posn
      return next_below if below?(prev_posn)
      return next_above if above?(prev_posn)
      return next_right if right_of?(prev_posn)
      next_left
    end

    def surrounding_positions
      [next_above, next_below, next_left, next_right]
    end

    def next_below
      Position.new(row + 1, column)
    end

    def next_above
      Position.new(row - 1, column)
    end

    def next_right
      Position.new(row, column + 1)
    end

    def next_left
      Position.new(row, column - 1)
    end

    def vertical_to?(other)
      above?(other) || below?(other)
    end

    def above?(other)
      row == other.row - 1
    end

    def below?(other)
      row == other.row + 1
    end

    def right_of?(other)
      column == other.column + 1
    end

    def ==(other)
      other.row == row && other.column == column
    end
  end
end
