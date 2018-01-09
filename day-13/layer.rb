#
# A layer of the firewall.
#
class Layer
  attr_reader :range

  def initialize(depth, range)
    @depth = depth
    @range = range
    @scanner = 0
    @direction = 1
    @caught = false
  end

  def move_scanner
    if @scanner.zero?
      @direction = 1
    elsif @scanner == @range - 1
      @direction = -1
    end
    @scanner += @direction
  end

  def severity
    @caught ? @depth * @range : 0
  end

  def check_for_catch
    @caught = @scanner.zero?
  end
end
