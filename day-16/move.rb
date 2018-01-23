#
# A dance move.
#
class Move
  # Parse the given string representation of a move and return a corresponding
  # Move object.
  #
  def self.parse(string)
    rest = string[1..-1]
    case string[0]
    when 's' then return Spin.parse(rest)
    when 'x' then return Exchange.parse(rest)
    when 'p' then return Partner.parse(rest)
    else
      raise ArgumentError, "Invalid move: #{string}"
    end
  end

  def perform(_)
    raise NotImplementedError
  end
end

#
# A spin move.
#
class Spin < Move
  def self.parse(string)
    new(string.to_i)
  end

  def initialize(size)
    @size = size
  end

  def perform(line)
    prefix = line[-@size..-1]
    suffix = line - prefix
    prefix + suffix
  end
end

#
# An exchange move.
#
class Exchange < Move
  def self.parse(string)
    pos_a, pos_b = string.split('/')
    new(pos_a.to_i, pos_b.to_i)
  end

  def initialize(position_a, position_b)
    @position_a = position_a
    @position_b = position_b
  end

  def perform(line)
    line[@position_a], line[@position_b] = line[@position_b], line[@position_a]
    line
  end
end

#
# A partner move.
#
class Partner < Move
  def self.parse(string)
    prog_a, prog_b = string.split('/')
    new(prog_a.to_sym, prog_b.to_sym)
  end

  def initialize(program_a, program_b)
    @program_a = program_a
    @program_b = program_b
  end

  def perform(line)
    idx_a = line.find_index(@program_a)
    idx_b = line.find_index(@program_b)
    Exchange.new(idx_a, idx_b).perform(line)
  end
end
