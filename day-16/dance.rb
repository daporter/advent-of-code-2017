require_relative 'move'

#
# A dance.
#
class Dance
  def self.parse(string)
    moves = string.strip.split(',').map { |move| Move.parse(move) }
    new(moves)
  end

  def initialize(moves)
    @moves = moves
    @initial_line = %i[a b c d e f g h i j k l m n o p]
  end

  def perform(initial_line = @initial_line)
    @moves.reduce(initial_line) { |line, move| move.perform(line) }
  end
end
