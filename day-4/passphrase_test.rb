require 'minitest/autorun'
require_relative 'passphrase'

class PassphraseTest < Minitest::Test
  # aa bb cc dd ee is valid.
  def test_distinct_words_is_valid
    passphrase = Passphrase.new('aa bb cc dd ee')
    assert passphrase.valid?
  end

  # aa bb cc dd aa is not valid - the word aa appears more than once.
  def test_duplicate_words_is_not_value
    passphrase = Passphrase.new('aa bb cc dd aa')
    assert !passphrase.valid?
  end

  # aa bb cc dd aaa is valid - aa and aaa count as different words.
  def test_different_length_words_is_valid
    passphrase = Passphrase.new('aa bb cc dd aaa')
    assert passphrase.valid?
  end
end
