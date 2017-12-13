require 'minitest/autorun'
require_relative 'captcha_1'
require_relative 'captcha_2'

class CaptchaTest < Minitest::Test
  def test_part_1_unit_sequence
    captcha = Captcha1.new('1')
    assert_equal 0, captcha.solve
  end

  def test_part_1_two_distinct
    captcha = Captcha1.new('12')
    assert_equal 0, captcha.solve
  end

  def test_part_1_single_pair
    captcha = Captcha1.new('11')
    assert_equal 2, captcha.solve
  end

  #   1122 produces a sum of 3 (1 + 2) because the first digit (1)
  #   matches the second digit and the third digit (2) matches the
  #   fourth digit.
  def test_part_1_multiple_pairs
    captcha = Captcha1.new('1122')
    assert_equal 3, captcha.solve
  end

  # 1111 produces 4 because each digit (all 1) matches the next.
  def test_part_1_all_identical
    captcha = Captcha1.new('1111')
    assert_equal 4, captcha.solve
  end

  # 1234 produces 0 because no digit matches the next.
  def test_part_1_no_pairs
    captcha = Captcha1.new('1234')
    assert_equal 0, captcha.solve
  end

  # 91212129 produces 9 because the only digit that matches the next
  # one is the last digit, 9.
  def test_part_1_complex
    captcha = Captcha1.new('91212129')
    assert_equal 9, captcha.solve
  end

  # 1212 produces 6: the list contains 4 items, and all four digits match the
  # digit 2 items ahead.
  def test_part_2_all_matches
    captcha = Captcha2.new('1212')
    assert_equal 6, captcha.solve
  end

  # 1221 produces 0, because every comparison is between a 1 and a 2.
  def test_part_2_no_matches
    captcha = Captcha2.new('1221')
    assert_equal 0, captcha.solve
  end

  # 123425 produces 4, because both 2s match each other, but no other digit
  # has a match.
  def test_part_2_some_matches
    captcha = Captcha2.new('123425')
    assert_equal 4, captcha.solve
  end

  # 123123 produces 12.
  def test_part_2_all_matches_complex
    captcha = Captcha2.new('123123')
    assert_equal 12, captcha.solve
  end

  # 12131415 produces 4.
  def test_part_2_some_matches_complex
    captcha = Captcha2.new('12131415')
    assert_equal 4, captcha.solve
  end
end
