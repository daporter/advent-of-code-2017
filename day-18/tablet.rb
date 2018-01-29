require_relative 'instruction'

class Tablet
  def initialize(code)
    @instructions = parse_code(code)
    @registers = Hash.new(0)
  end

  def parse_code(code)
    code.strip.lines.map do |instruction|
      Tablet.parse_instruction(instruction)
    end
  end

  def self.parse_instruction(string)
    name, args = tokenize_string(string)
    case name
    when 'set' then SetInstruction.parse(args)
    when 'add' then AddInstruction.parse(args)
    when 'mul' then MulInstruction.parse(args)
    when 'mod' then ModInstruction.parse(args)
    when 'snd' then SndInstruction.parse(args)
    when 'rcv' then RcvInstruction.parse(args)
    when 'jgz' then JgzInstruction.parse(args)
    end
  end

  def self.tokenize_string(string)
    tokens = string.split
    [tokens[0], tokens[1..-1]]
  end

  def run_until_frequency_recovered
    loop do
      execute_next_instruction
      break if program_terminated?
    end
    @registers[:rcv]
  end

  def execute_next_instruction
    next_instruction = @instructions[@registers[:pc]]
    @registers = next_instruction.execute(@registers)
    @registers[:pc] += 1
  end

  def program_terminated?
    pc = @registers[:pc]
    pc < 0 || pc >= @instructions.count || !@registers[:rcv].zero?
  end
end
