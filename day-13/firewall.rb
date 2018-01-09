require_relative 'layer'

#
# Implements a firewall consisting of a number of layers, each with a security
# scanner.
#
class Firewall
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

  attr_reader :layers

  def initialize(layers)
    @layers = layers
    @cur_packet_depth = -1
  end

  def trip_severity
    move_packet_through
    calculate_severity
  end

  def move_packet_through
    tick_picosecond until packet_through?
  end

  def tick_picosecond
    @cur_packet_depth += 1
    @layers[@cur_packet_depth].check_for_catch
    @layers.each(&:move_scanner)
  end

  def packet_through?
    @cur_packet_depth >= @layers.count - 1
  end

  def calculate_severity
    @layers.reduce(0) do |severity, layer|
      layer ? severity + layer.severity : severity
    end
  end

  def layer_range(layer_num)
    layer = @layers[layer_num]
    layer ? layer.range : 0
  end
end
