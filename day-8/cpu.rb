require_relative 'instruction'

class Cpu
  def initialize(text)
    @instructions = text.strip.lines.map do |line|
      Instruction.parse(line.strip)
    end
    @pc = 0
    @registers = {}
  end

  def execute
    execute_next_instruction until terminated?
  end

  def execute_next_instruction
    return if terminated?

    instruction = @instructions[@pc]
    instruction.operation.execute(self) if instruction.predicate.evaluate(self)
    @pc += 1
  end

  def largest_value_in_any_register
    @registers.values.max
  end

  def get_register_value(name)
    @registers.fetch(name, 0)
  end

  def set_register_value(name, value)
    @registers[name] = value
  end

  def terminated?
    @pc >= @instructions.count
  end
end
