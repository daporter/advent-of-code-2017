class MemoryReallocator
  attr_reader :banks
  attr_reader :cycles
  attr_reader :cycles_in_loop

  def initialize(banks)
    @banks = banks
    @previous_states = []
    @cycles = 0
    @cycles_in_loop = 0
  end

  def execute
    perform_cycle until loop_detected?
  end

  def perform_cycle
    @previous_states.unshift @banks.dup
    redistribute_blocks(bank_with_most_blocks)
    @cycles += 1
  end

  def loop_detected?
    @cycles_in_loop = (@previous_states.index(@banks) || 0) + 1
    @cycles_in_loop > 1
  end

  def bank_with_most_blocks
    @banks.index(@banks.max)
  end

  def redistribute_blocks(source_bank)
    blocks = @banks[source_bank]
    @banks[source_bank] = 0
    redistribute(blocks, next_bank(source_bank))
  end

  def redistribute(blocks, start_bank)
    cur_bank = start_bank
    while blocks > 0
      @banks[cur_bank] += 1
      blocks -= 1
      cur_bank = next_bank(cur_bank)
    end
  end

  def next_bank(bank)
    (bank + 1) % @banks.count
  end
end
