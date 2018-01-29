#
# A single instruction.
#
class Instruction
  def execute
    raise NotImplementedError
  end

  def self.parse_reg_or_num(reg_or_num)
    reg_or_num =~ /[a-z]/ ? reg_or_num.to_sym : reg_or_num.to_i
  end

  def self.read_reg_or_num(reg_or_num, registers)
    reg_or_num.kind_of?(Symbol) ? registers[reg_or_num] : reg_or_num
  end
end

class SetInstruction < Instruction
  def self.parse(tokens)
    new(tokens[0].to_sym, tokens[1])
  end

  def initialize(register, reg_or_num)
    @register = register
    @reg_or_num = Instruction.parse_reg_or_num(reg_or_num)
  end

  def execute(registers)
    registers[@register] = Instruction.read_reg_or_num(@reg_or_num, registers)
    registers
  end
end

class AddInstruction < Instruction
  def self.parse(tokens)
    new(tokens[0].to_sym, tokens[1].to_i)
  end

  def initialize(register, value)
    @register = register
    @value = value
  end

  def execute(registers)
    registers[@register] += @value
    registers
  end
end

class MulInstruction < Instruction
  def self.parse(tokens)
    new(tokens[0].to_sym, tokens[1])
  end

  def initialize(register, reg_or_num)
    @register = register
    @reg_or_num = Instruction.parse_reg_or_num(reg_or_num)
  end

  def execute(registers)
    registers[@register] *= Instruction.read_reg_or_num(@reg_or_num, registers)
    registers
  end
end

class ModInstruction < Instruction
  def self.parse(tokens)
    new(tokens[0].to_sym, tokens[1])
  end

  def initialize(register, reg_or_num)
    @register = register
    @reg_or_num = Instruction.parse_reg_or_num(reg_or_num)
  end

  def execute(registers)
    registers[@register] %= Instruction.read_reg_or_num(@reg_or_num, registers)
    registers
  end
end

class SndInstruction < Instruction
  def self.parse(tokens)
    new(tokens[0].to_sym)
  end

  def initialize(register)
    @register = register
  end

  def execute(registers)
    registers[:snd] = registers[@register]
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
    registers[:rcv] = registers[:snd] unless registers[@register].zero?
    registers
  end
end

class JgzInstruction < Instruction
  def self.parse(tokens)
    new(tokens[0].to_sym, tokens[1].to_i)
  end

  def initialize(register, offset)
    @register = register
    @offset = offset
  end

  def execute(registers)
    registers[:pc] += @offset - 1 if registers[@register] > 0
    registers
  end
end
