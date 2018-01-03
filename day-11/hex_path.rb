require_relative 'hex_step'

# Implements a path through a hex grid.
#
# We can see that the following step laws hold:
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
  attr_reader :steps

  # Creates a new instance from a string representation of a path.
  def self.from_string(string)
    steps = string.split(',').map { |dir| HexStep.new(dir) }
    new(steps)
  end

  def initialize(steps)
    @steps = steps
  end

  # Returns a new HexPath to the same destination such that the number of
  # steps is minimised.
  def minimise
    HexPath.new(HexPath.minimise_path(@steps, []))
  end

  # We minimise a path via the following algorithm:
  #
  # Let s be the first step of path p.  Let p' be the minimisation of the path
  # without s.  Let t be a complement of s in p', and let p'' be p' without t.
  # if s and t have a null step reduction, return p''.  Otherwise, let w be
  # the minimisation of steps s and t.  Return the minimisation of w + p''.
  # Otherwise if no complement of s exists in p', return s + p'.
  def self.minimise_path(path, acc)
    return path + acc if path.size <= 1

    step, rest = path[0], path[1..-1]

    idx = rest.index { |other| step.complement?(other) }
    complement = rest.delete_at(idx || rest.length)

    if complement && step.null_reduction?(complement)
      minimise_path(rest, acc)
    elsif complement
      minimise_path([step.minimise(complement)] + rest, acc)
    else
      minimise_path(rest, [step] + acc)
    end
  end

  def step_count
    @steps.count
  end
end
