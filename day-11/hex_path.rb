# Implements a path through a hex grid.
#
# We can see that the following "step laws" hold:
#
# n,  s  == .
# n,  se == ne
# n,  sw == nw
#
# ne, sw == .
# ne, nw == n
# ne, s  == se
#
# se, nw == .
# se, n  == ne
# se, sw == s
#
# s,  n  == .
# s,  ne == se
# s,  nw == sw
#
# sw, ne == .
# sw, se == s
# sw, n  == nw
#
# nw, se == .
# nw, s  == sw
# nw, ne == n
#
# And we can further see that the steps on the LHS need not be consecutive,
# i.e, we have:
#
# n, x1, ..., xn, s  == x1, ... xn
# n, x1, ..., xn, se == ne, x1, ... xn
# n, x1, ..., xn, sw == nw, x1, ..., xn
# etc.
#
# where each x is any step.
#
# Thus we can simplify a given path by replacing all such pairs with their
# equivalent single step.
#
class HexPath
  STEP_REDUCTIONS = {
    n:  { s: nil, se: :ne, sw: :nw },
    ne: { sw: nil, nw: :n, s: :se },
    se: { nw: nil, n: :ne, sw: :s  },
    s:  { n: nil, ne: :se, nw: :sw },
    sw: { ne: nil, se: :s, n: :nw },
    nw: { se: nil, s: :sw, ne: :n }
  }.freeze

  attr_reader :steps

  # Creates a new instance from a string representation of a path.
  def self.from_string(string)
    steps = string.split(',').map(&:to_sym)
    new(steps)
  end

  def initialize(steps)
    @steps = steps
    @furthest_from_start = 0
  end

  # Returns the shortest path to the destination of this path.
  def minimise
    HexPath.new(minimise_path(@steps))
  end

  def minimise_path(path)
    path.reduce([]) { |path_m, step| minimised_path_add_step(path_m, step) }
  end

  # minimised_path, step -> minimised_path
  # Returns the minimised path resulting from extending 'path' by 'step'.
  def minimised_path_add_step(path, step)
    if HexPath.path_contains_complement?(path, step)
      minimised_path_add_step_with_complement(path, step)
    else
      minimised_path_add_step_without_complement(path, step)
    end
  end

  # minimised_path, step -> boolean
  #
  # Determines whether 'path' contains a step complementary to 'step'.  Two
  # steps are complementary if they can be reduced to 0 or 1 equivalent steps.
  def self.path_contains_complement?(path, step)
    path.any? { |other| complementary?(step, other) }
  end

  def minimised_path_add_step_with_complement(path, step)
    path_r, comp = HexPath.path_remove_complement(path, step)
    step_r = HexPath.reduce_steps(step, comp)
    step_r ? minimised_path_add_step(path_r, step_r) : path_r
  end

  def minimised_path_add_step_without_complement(path, step)
    path << step
    len = path.length
    @furthest_from_start = len if @furthest_from_start < len
    path
  end

  # path, step -> [path, step]
  #
  # Removes the complement step of 'step' and returns the new path and the
  # complement.
  def self.path_remove_complement(path, step)
    idx = path.index { |other| complementary?(step, other) }
    comp = path.delete_at(idx)
    [path, comp]
  end

  # step, step -> boolean
  #
  # Determines whether 'step' and 'other' are complementary.
  def self.complementary?(step, other)
    STEP_REDUCTIONS.fetch(step).fetch(other)
    true
  rescue KeyError
    false
  end

  # step, step -> step-or-nil
  #
  # Reduces 'step' and 'comp' to their equivalent single step, or nil if they
  # cancel each other.  Raises an exception if the steps are not
  # complementary.
  def self.reduce_steps(step, comp)
    return STEP_REDUCTIONS[step][comp] if complementary?(step, comp)
    raise ArgumentError, "Steps not complementary: #{step}, #{comp}"
  end

  def step_count
    @steps.count
  end

  def furthest_from_start
    minimise if @furthest_from_start.zero?
    @furthest_from_start
  end
end
