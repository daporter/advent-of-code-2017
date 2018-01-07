#
# Represents the direct pipes that exist among a set of programs.
#
class DigitalPlumber
  # A Program is a non-negative integer.
  # It represents the program's ID.

  # A List-of-programs is one of:
  # - []
  # - List-of-programs << Program

  # A Pipe-set is a Hash:
  # { Program => List-of-programs }
  # It represents the pipes for a particular program.

  # A List-of-pipe-sets is one of:
  # - []
  # - List-of-pipe-sets << Pipe-set
  # It represents the pipes for all programs.

  # A Program-group is one of:
  # - []
  # - Program-group << Program
  # It represents programs that are indirectly connected to each other.

  def initialize(pipe_sets = {})
    @pipe_sets = pipe_sets
  end

  def self.pipe_sets_from_string(string)
    pipe_sets = string.strip.lines.map { |line| pipe_set_from_string(line) }
    new(pipe_sets.reduce(&:merge))
  end

  def self.pipe_set_from_string(string)
    program, connections_s = string.strip.split(' <-> ')
    { program.to_i => programs_from_string(connections_s) }
  end

  def self.programs_from_string(string)
    string.strip.split(',').map(&:to_i)
  end

  # Program -> Program-group
  # Determines the programs indirectly connected to 'program'.
  def program_group(program)
    program_group_helper(program, []).sort
  end

  def program_group_helper(program, accumulator)
    accumulator << program
    pipes = @pipe_sets.fetch(program, [])
    program_groups_helper(pipes, accumulator)
  end

  def program_groups_helper(programs, accumulator)
    programs.each do |program|
      next if accumulator.include?(program)
      program_group_helper(program, accumulator)
    end
    accumulator
  end
end
