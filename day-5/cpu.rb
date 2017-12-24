class Cpu
  attr_reader :instructions
  attr_reader :program_counter
  attr_reader :steps

  def initialize(instructions)
    @instructions = instructions
    @program_counter = 0
    @steps = 0
  end

  def execute
    step until complete?
  end

  def complete?
    @program_counter > @instructions.count - 1
  end

  def step
    pc_before = @program_counter
    @program_counter += @instructions[@program_counter]
    @instructions[pc_before] += 1
    @steps += 1
  end
end
