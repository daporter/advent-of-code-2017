#
# A single instruction.
#
class Instruction
  def execute
    raise NotImplementedError
  end

  def self.parse_reg_or_int(reg_or_int)
    reg_or_int =~ /[a-z]/ ? reg_or_int.to_sym : reg_or_int.to_i
  end

  def self.eval_reg_or_int(reg_or_int, registers)
    reg_or_int.is_a?(Symbol) ? registers[reg_or_int] : reg_or_int
  end
end

class ArithInstruction < Instruction
  def self.parse(tokens)
    new(tokens[0].to_sym, tokens[1])
  end

  def initialize(register, reg_or_int)
    @register = register
    @reg_or_int = Instruction.parse_reg_or_int(reg_or_int)
  end

  def execute(registers)
    arg = Instruction.eval_reg_or_int(@reg_or_int, registers)
    registers[@register] = registers[@register].send(op, arg)
    registers
  end

  def op
    raise NotImplementedError
  end
end

class AddInstruction < ArithInstruction
  def op
    :+
  end
end

class MulInstruction < ArithInstruction
  def op
    :*
  end
end

class ModInstruction < ArithInstruction
  def op
    :%
  end
end

class SetInstruction < ArithInstruction
  def execute(registers)
    registers[@register] = Instruction.eval_reg_or_int(@reg_or_int, registers)
    registers
  end
end

class SndInstruction < Instruction
  def self.parse(tokens)
    new(tokens[0])
  end

  def initialize(reg_or_int)
    @reg_or_int = Instruction.parse_reg_or_int(reg_or_int)
  end

  def execute(registers)
    registers[:snd] << Instruction.eval_reg_or_int(@reg_or_int, registers)
    registers[:send_count] += 1
    registers
  end
end

class RcvInstruction < Instruction
  def self.parse(tokens)
    new(tokens[0].to_sym)
  end

  def initialize(register)
    @register = register
  end

  def execute(registers)
    queue = registers[:rcv]
    if queue.any?
      registers[@register] = queue.shift
      registers[:waiting] = false
    else
      registers[:waiting] = true
      registers[:pc] -= 1
    end
    registers
  end
end

class JgzInstruction < Instruction
  def self.parse(tokens)
    new(tokens[0], tokens[1])
  end

  def initialize(test_reg_or_int, offset_reg_or_int)
    @test_reg_or_int = Instruction.parse_reg_or_int(test_reg_or_int)
    @offset_reg_or_int = Instruction.parse_reg_or_int(offset_reg_or_int)
  end

  def execute(registers)
    test = Instruction.eval_reg_or_int(@test_reg_or_int, registers)
    offset = Instruction.eval_reg_or_int(@offset_reg_or_int, registers)
    if (test.is_a?(Symbol) && registers[test] > 0) || test > 0
      registers[:pc] += offset - 1
    end
    registers
  end
end
