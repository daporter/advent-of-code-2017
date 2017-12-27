require_relative 'instruction'

class Cpu
  attr_reader :largest_value_held

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
    update_largest_value_held
  end

  def largest_value_in_any_register
    @registers.values.max
  end

  def get_register_value(name)
    set_register_value(name, 0) unless @registers.key?(name)
    @registers.fetch(name)
  end

  def set_register_value(name, value)
    @registers[name] = value
  end

  def terminated?
    @pc >= @instructions.count
  end

  private

  def update_largest_value_held
    if @largest_value_held.nil?
      @largest_value_held = largest_value_in_any_register
    elsif @largest_value_held < largest_value_in_any_register
      @largest_value_held = largest_value_in_any_register
    end
  end
end
