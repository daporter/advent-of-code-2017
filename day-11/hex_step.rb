# Represents a step in a path through a HexGrid.
class HexStep
  DIRECTIONS = [:n, :ne, :se, :s, :sw, :nw]

  attr_reader :direction

  def self.n
    new('n')
  end

  def self.ne
    new('ne')
  end

  def self.se
    new('se')
  end

  def self.s
    new('s')
  end

  def self.sw
    new('sw')
  end

  def self.nw
    new('nw')
  end

  def initialize(string)
    dir = string.to_sym
    raise(ArgumentError, string) unless DIRECTIONS.include?(dir)
    @direction = dir
  end

  def complement?(other_step)
    dir = other_step.direction
    case @direction
    when :n
      [:s, :se, :sw].include?(dir)
    when :ne
      [:sw, :nw, :s].include?(dir)
    when :se
      [:nw, :n, :sw].include?(dir)
    when :s
      [:n, :ne, :nw].include?(dir)
    when :sw
      [:ne, :se, :n].include?(dir)
    when :nw
      [:se, :s, :ne].include?(dir)
    end
  end

  def null_reduction?(other_step)
    dir = other_step.direction
    case @direction
    when :n  then return dir == :s
    when :ne then return dir == :sw
    when :se then return dir == :nw
    when :s  then return dir == :n
    when :sw then return dir == :ne
    when :nw then return dir == :se
    end
  end

  def minimise(other_step)
    dir = other_step.direction
    case @direction
    when :n
      return HexStep.ne if dir == :se
      return HexStep.nw if dir == :sw
    when :ne
      return HexStep.n  if dir == :nw
      return HexStep.se if dir == :s
    when :se
      return HexStep.ne if dir == :n
      return HexStep.s  if dir == :sw
    when :s
      return HexStep.se if dir == :ne
      return HexStep.sw if dir == :nw
    when :sw
      return HexStep.s  if dir == :se
      return HexStep.nw if dir == :n
    when :nw
      return HexStep.sw if dir == :s
      return HexStep.n  if dir == :ne
    end
  end

  def ==(other_step)
    @direction = other_step.direction
  end
end
