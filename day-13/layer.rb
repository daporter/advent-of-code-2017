#
# A layer of the firewall.
#
class Layer
  attr_reader :depth
  attr_reader :range
  attr_reader :scanner
  attr_reader :direction
  attr_reader :caught_packet

  def initialize(depth, range)
    @depth = depth
    @range = range
    initialise_scanner
  end

  def initialise_scanner
    @scanner = 0
    @direction = 1
    @caught_packet = false
  end

  # Set the scanner to the position it would be after 'step' steps.
  def at_step(step)
    return unless scanner_present?
    traversals, cur_dir_steps = step.divmod(range - 1)
    if traversals.even?
      @direction = 1
      @scanner = cur_dir_steps
    else
      @direction = -1
      @scanner = range - 1 - cur_dir_steps
    end
  end

  def move_scanner
    return if range <= 1
    if scanner.zero?
      @direction = 1
    elsif scanner == range - 1
      @direction = -1
    end
    @scanner += direction
  end

  def caught_packet?
    caught_packet
  end

  def severity
    caught_packet? ? @depth * range : 0
  end

  def check_for_catch
    @caught_packet = scanner_present? && scanner.zero?
  end

  def scanner_present?
    range > 0
  end

  # Resets this layer to its initial state.
  def reset
    initialise_scanner
  end
end
