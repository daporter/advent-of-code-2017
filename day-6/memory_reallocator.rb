class MemoryReallocator
  attr_reader :banks

  def initialize(banks)
    @banks = banks
    @previous_states = []
    @num_cycles = 0
  end

  def cycles_until_loop_detected
    perform_cycle until loop_detected?
    @num_cycles
  end

  def perform_cycle
    @previous_states << @banks.dup
    redistribute_blocks(bank_with_most_blocks)
    @num_cycles += 1
  end

  def loop_detected?
    @previous_states.include?(@banks)
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
