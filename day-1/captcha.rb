class Captcha
  def initialize(digits)
    @sequence = to_sequence(digits)
  end

  def solve
    return 0 if @sequence.length < 2

    sum = 0
    for index in (0..@sequence.length) do
      current_digit = @sequence[index]
      next_digit    = @sequence[increment(index)]

      sum += current_digit  if next_digit == current_digit
    end

    sum
  end

  private

  def to_sequence(digits)
    @sequence = digits.split(//).map(&:to_i)
  end

  def increment(index)
    (index + 1) % @sequence.length
  end
end
