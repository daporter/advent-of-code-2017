require_relative 'instruction'

class Program
  attr_reader :registers

  def initialize(program_id, instructions, send_queue, receive_queue)
    @instructions = instructions
    initialize_registers(program_id, send_queue, receive_queue)
  end

  def initialize_registers(program_id, send_queue, receive_queue)
    @registers = Hash.new(0)
    @registers[:p] = program_id
    @registers[:snd] = send_queue
    @registers[:rcv] = receive_queue
    @registers[:send_count] = 0
    @registers[:waiting] = false
    @registers[:pc] = 0
  end

  def execute_next_instruction
    @registers = next_instruction.execute(@registers)
    @registers[:pc] += 1
  end

  def next_instruction
    @instructions[@registers[:pc]]
  end

  def waiting_for_data?
    @registers[:waiting]
  end

  def terminated?
    pc = @registers[:pc]
    pc < 0 || pc >= @instructions.count
  end

  def send_count
    @registers[:send_count]
  end
end
