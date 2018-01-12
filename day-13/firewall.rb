require_relative 'layer'

#
# Implements a firewall consisting of a number of layers, each with a security
# scanner.
#
class Firewall
  MAX_DELAY = 10_000_000

  attr_reader :layers
  attr_reader :cur_packet_depth

  def self.from_string(string)
    layers = []
    cur_depth = 0
    string.strip.lines.each do |line|
      depth, range = line.split(': ')
      depth = depth.to_i
      while cur_depth < depth
        layers[cur_depth] = Layer.new(cur_depth, 0)
        cur_depth += 1
      end
      layers[depth] = Layer.new(depth, range.to_i)
      cur_depth += 1
    end
    new(layers)
  end

  def initialize(layers)
    @layers = layers
    reset
  end

  def trip_severity
    move_packet_through
    calculate_severity
  end

  # Determines the fewest picoseconds of delay needed for the packet to pass
  # through the firewall without being caught.
  def min_delay_to_pass_through
    delay_values = (-1..MAX_DELAY).to_a
    loop do
      delay = delay_values.shift
      delay_for(delay)
      move_packet_through
      return delay if packet_through_cleanly?
      delay_values = remove_cycles(delay_values, delay)
      reset
    end
  end

  def delay_for(picoseconds)
    @layers.each { |layer| layer.at_step(picoseconds) }
  end

  def move_packet_through
    tick_picosecond_with_move until packet_through?
  end

  def tick_picosecond_with_move
    @cur_packet_depth += 1
    tick_picosecond
  end

  def tick_picosecond
    @layers[cur_packet_depth].check_for_catch
    move_scanners_one_step
  end

  def move_scanners_one_step
    @layers.each(&:move_scanner)
  end

  def packet_through?
    cur_packet_depth >= @layers.count - 1
  end

  def packet_through_cleanly?
    @layers.none?(&:caught_packet?)
  end

  # Remove those elements of 'delay_values' which would cause the packet to be
  # caught by the same layer that captures the packet using the delay
  # value 'delay'.
  def remove_cycles(delay_values, delay)
    idx = @layers.find_index(&:caught_packet?)
    range = layers[idx].range
    delay_values.reject { |dv| ((dv - delay) % (2 * (range - 1))).zero? }
  end

  # Resets this firewall to its initial state.
  def reset
    @layers.each(&:reset)
    @cur_packet_depth = -1      # not in firewall yet
  end

  def calculate_severity
    @layers.reduce(0) do |severity, layer|
      layer ? severity + layer.severity : severity
    end
  end

  def scanner_positions
    @layers.map(&:scanner)
  end

  def layer_range(layer_num)
    layer = @layers[layer_num]
    layer ? layer.range : 0
  end
end
