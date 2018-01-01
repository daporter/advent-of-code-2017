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
    update_instruction(pc_before)
    @steps += 1
  end

  def update_instruction(_)
    raise NotImplementedError
  end
end

class SimpleCpu < Cpu
  def update_instruction(number)
    @instructions[number] += 1
  end
end

class ComplexCpu < Cpu
  def update_instruction(number)
    @instructions[number] += (@instructions[number] >= 3 ? -1 : 1)
  end
end
