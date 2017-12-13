require 'minitest/autorun'
require_relative 'captcha'

class CaptchaTest < Minitest::Test
  def test_unit_sequence
    captcha = Captcha.new('1')
    assert_equal 0, captcha.solve
  end

  def test_two_distinct
    captcha = Captcha.new('12')
    assert_equal 0, captcha.solve
  end
  
  def test_single_pair
    captcha = Captcha.new('11')
    assert_equal 2, captcha.solve
  end
  
  #   1122 produces a sum of 3 (1 + 2) because the first digit (1)
  #   matches the second digit and the third digit (2) matches the
  #   fourth digit.
  def test_multiple_pairs
    captcha = Captcha.new('1122')
    assert_equal 3, captcha.solve
  end
  
  # 1111 produces 4 because each digit (all 1) matches the next.
  def test_all_identical
    captcha = Captcha.new('1111')
    assert_equal 4, captcha.solve
  end
  
  # 1234 produces 0 because no digit matches the next.
  def test_no_pairs
    captcha = Captcha.new('1234')
    assert_equal 0, captcha.solve
  end
  
  # 91212129 produces 9 because the only digit that matches the next
  # one is the last digit, 9.
  def test_complex
    captcha = Captcha.new('91212129')
    assert_equal 9, captcha.solve
  end
end




