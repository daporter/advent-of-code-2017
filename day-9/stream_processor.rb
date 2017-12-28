#
# Process a stream containing "groups" and "garbage".
#
class StreamProcessor
  attr_reader :score
  attr_reader :garbage_chars_count

  def initialize(stream)
    @stream = stream.chars
    @score = 0
    @garbage_chars_count = 0
  end

  def process
    process_group(0)
  end

  def process_group(depth)
    @score += depth
    while chars_remaining?
      case next_char
      when '}' then break
      when '<' then process_garbage
      when '{' then process_group(depth + 1)
      end
    end
  end

  def process_garbage
    char = next_char
    if char == '!'
      next_char
      process_garbage
    elsif char != '>'
      @garbage_chars_count += 1
      process_garbage
    end
  end

  def chars_remaining?
    @stream.any?
  end

  def next_char
    @stream.shift
  end
end
