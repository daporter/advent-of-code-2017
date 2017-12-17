# The algorithm for calculating the Manhattan Distance from square n to square
# 1 is to trace the path of the consecutive squares from square 1 to square n,
# maintaining the current column and row offset as we go. When we get to
# square n we can use the resulting offsets to calculate the Manhattan
# Distance to square 1.

class MemoryGrid
  def self.steps_from(target_square)
    cur_square = GridPosition.new(target_square)
    cur_square.trace_path
    cur_square.distance
  end
end

class GridPosition
  def initialize(target)
    @square_number = 1
    @column_offset = 0
    @row_offset = 0
    @target = target
  end

  def trace_path
    cur_straight_path_length = 1

    until target_reached?
      trace_straight_path(:right, cur_straight_path_length)
      trace_straight_path(:up, cur_straight_path_length)
      cur_straight_path_length += 1
      trace_straight_path(:left, cur_straight_path_length)
      trace_straight_path(:down, cur_straight_path_length)
      cur_straight_path_length += 1
    end
  end

  def trace_straight_path(direction, path_length)
    step = 1
    while step <= path_length && !target_reached?
      move(direction)
      step += 1
    end
  end

  def move(direction)
    case direction
    when :right then @column_offset += 1
    when :up    then @row_offset -= 1
    when :left  then @column_offset -= 1
    when :down  then @row_offset += 1
    end
    @square_number += 1
  end

  def distance
    @column_offset.abs + @row_offset.abs
  end

  def target_reached?
    @square_number == @target
  end
end
