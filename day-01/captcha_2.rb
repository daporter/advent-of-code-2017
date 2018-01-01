require_relative 'captcha'

class Captcha2 < Captcha
  def initialize(digits)
    super(digits)
    @index_pair_offset = @sequence.length / 2
  end
end
