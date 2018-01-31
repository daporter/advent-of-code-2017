require_relative 'program'

class Tablet
  def initialize(code)
    instructions = Tablet.parse_code(code)
    receive_queue = []
    send_queue = []
    @programs = [Program.new(0, instructions, send_queue, receive_queue),
                 Program.new(1, instructions, receive_queue, send_queue)]
  end

  def self.parse_code(code)
    code.strip.lines.map do |instruction|
      parse_instruction(instruction)
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

  def run_programs
    loop do
      @programs.each(&:execute_next_instruction)
      break if terminated?
    end
  end

  def terminated?
    @programs.all?(&:waiting_for_data?) || @programs.all?(&:terminated?)
  end

  def program(program_id)
    @programs[program_id]
  end
end
