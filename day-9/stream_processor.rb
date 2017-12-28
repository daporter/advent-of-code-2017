#
# Process a stream containing "groups" and "garbage".
#
class StreamProcessor
  def initialize(stream)
    @stream = stream.chars
  end

  def score
    process_group(0)
  end

  def process_group(depth)
    score = depth

    while chars_remaining?
      case next_char
      when '}' then break
      when '<' then process_garbage
      when '{' then score += process_group(depth + 1)
      end
    end

    score
  end

  def process_garbage
    char = next_char
    if char == '!'
      # ignore char following '!'
      next_char
      process_garbage
    elsif char != '>'
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
