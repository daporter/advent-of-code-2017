require_relative 'captcha'

class Captcha1 < Captcha
  def initialize(digits)
    super(digits)
    @index_pair_offset = 1
  end
end
