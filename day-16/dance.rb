require_relative 'move'

#
# A dance.
#
class Dance
  INITIAL_LINE = %i[a b c d e f g h i j k l m n o p].freeze

  def self.parse(string)
    moves = string.strip.split(',').map { |move| Move.parse(move) }
    new(moves)
  end

  def initialize(moves)
    @moves = moves
    @prev_dances = {}
  end

  def perform(initial_line = INITIAL_LINE)
    @moves.reduce(initial_line) { |line, move| move.perform(line) }
  end

  def perform_n(num_dances, line = INITIAL_LINE)
    if num_dances.zero?
      line
    else
      perform_n(num_dances_left(num_dances, line), perform(line))
    end
  end

  def num_dances_left(initial_left, line)
    line_s = Dance.line_s(line)
    prev_left = @prev_dances[line_s]
    if prev_left
      initial_left % (prev_left - initial_left) - 1
    else
      @prev_dances[line_s] = initial_left
      initial_left - 1
    end
  end

  def self.line_s(line)
    line.map(&:to_s).join
  end
end
