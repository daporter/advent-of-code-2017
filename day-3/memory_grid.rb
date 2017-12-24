# The algorithm for calculating the Manhattan Distance from square n to square
# 1 is to trace the path of the consecutive squares from square 1 to square n,
# maintaining the current column and row offset as we go. When we get to
# square n we can use the resulting offsets to calculate the Manhattan
# Distance to square 1.

class MemoryGrid
  def initialize
    @squares = [GridSquare.first]
  end

  def steps_from(target_square_number)
    trace_path_to_square_with_number(target_square_number)
    @squares.last.distance
  end

  def trace_path_to_square_with_number(target_square_number)
    cur_straight_path_length = 1
    until target_reached?(target_square_number)
      trace_straight_path(:right,
                          cur_straight_path_length,
                          target_square_number)
      trace_straight_path(:up, cur_straight_path_length, target_square_number)
      cur_straight_path_length += 1
      trace_straight_path(:left, cur_straight_path_length, target_square_number)
      trace_straight_path(:down, cur_straight_path_length, target_square_number)
      cur_straight_path_length += 1
    end
  end

  def trace_straight_path(direction, path_length, target_square_number)
    step = 1
    while step <= path_length && !target_reached?(target_square_number)
      new_square = @squares.last.move(direction)
      @squares << new_square
      step += 1
    end
  end

  def target_reached?(target_square_number)
    @squares.size == target_square_number
  end

  # -------

  def first_value_larger_than(target_value)
    trace_path_to_square_with_value_greater_than(target_value)
    @squares.last.value
  end

  def trace_path_to_square_with_value_greater_than(target_value)
    cur_straight_path_length = 1
    until target_value_reached?(target_value)
      trace_straight_path_to_value(:right,
                                   cur_straight_path_length,
                                   target_value)
      trace_straight_path_to_value(:up, cur_straight_path_length, target_value)
      cur_straight_path_length += 1
      trace_straight_path_to_value(:left, cur_straight_path_length, target_value)
      trace_straight_path_to_value(:down, cur_straight_path_length, target_value)
      cur_straight_path_length += 1
    end
  end

  def trace_straight_path_to_value(direction, path_length, target_value)
    step = 1
    while step <= path_length && !target_value_reached?(target_value)
      new_square = @squares.last.move(direction)
      new_square.value = @squares.find_all { |s| new_square.neighbour?(s) }.map(&:value).reduce(&:+)
      @squares << new_square
      step += 1
    end
  end

  def target_value_reached?(target_value)
    @squares.last.value > target_value
  end
end

class GridSquare
  attr_reader :number
  attr_reader :column_offset
  attr_reader :row_offset
  attr_accessor :value

  def initialize(number, column_offset, row_offset, value=nil)
    @number = number
    @column_offset = column_offset
    @row_offset = row_offset
    @value = value
  end

  def self.first
    new(1, 0, 0, 1)
  end

  def move(direction)
    case direction
    when :right then move_right
    when :up then move_up
    when :left then move_left
    when :down then move_down
    end
  end

  def move_right
    new_square = GridSquare.new(@number + 1, @column_offset + 1, @row_offset)
  end

  def move_up
    GridSquare.new(@number + 1, @column_offset, @row_offset - 1)
    # new-value = sum above-left + left + below-left + below
  end

  def move_left
    GridSquare.new(@number + 1, @column_offset - 1, @row_offset)
    # new-value = sum below-left + below + below-right + right
  end

  def move_down
    GridSquare.new(@number + 1, @column_offset, @row_offset + 1)
    # new-value = sum below-right + right + above-right + above
  end

  def neighbour?(other_square)
    column_diff = (@column_offset - other_square.column_offset).abs
    row_diff    = (@row_offset - other_square.row_offset).abs
    [column_diff, row_diff].max <= 1
  end

  def distance
    @column_offset.abs + @row_offset.abs
  end
end
