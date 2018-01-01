require 'minitest/autorun'
require_relative 'passphrase'

class PassphraseTest < Minitest::Test
  # aa bb cc dd ee is valid.
  def test_distinct_words_is_duplicate_valid
    passphrase = Passphrase.new('aa bb cc dd ee')
    assert passphrase.duplicate_valid?
  end

  # aa bb cc dd aa is not valid - the word aa appears more than once.
  def test_duplicate_words_is_not_valid
    passphrase = Passphrase.new('aa bb cc dd aa')
    assert !passphrase.duplicate_valid?
  end

  # aa bb cc dd aaa is valid - aa and aaa count as different words.
  def test_different_length_words_is_duplicate_valid
    passphrase = Passphrase.new('aa bb cc dd aaa')
    assert passphrase.duplicate_valid?
  end

  # abcde fghij is a valid passphrase.
  def test_distinct_words_is_anagram_valid
    passphrase = Passphrase.new('abcde fghij')
    assert passphrase.anagram_valid?
  end

  # abcde xyz ecdab is not valid - the letters from the third word can be
  # rearranged to form the first word.
  def test_anagram_words_is_not_anagram_valid
    passphrase = Passphrase.new('abcde xyz ecdab')
    assert !passphrase.anagram_valid?
  end

  # a ab abc abd abf abj is a valid passphrase, because all letters need to
  # be used when forming another word.
  def test_no_anagrams_is_anagram_valid
    passphrase = Passphrase.new('a ab abc abd abf abj')
    assert passphrase.anagram_valid?
  end

  # iiii oiii ooii oooi oooo is valid.
  def test_same_letters_but_not_anagrams_is_anagram_valid
    passphrase = Passphrase.new('iiii oiii ooii oooi oooo')
    assert passphrase.anagram_valid?
  end

  # oiii ioii iioi iiio is not valid - any of these words can be rearranged
  # to form any other word.
  def test_same_letters_and_anagrams_is_not_anagram_valid
    passphrase = Passphrase.new('oiii ioii iioi iiio')
    assert !passphrase.anagram_valid?
  end

  def test_non_first_word_anagram_is_not_anagram_valid
    passphrase = Passphrase.new('foo azza bar zaaz baz')
    assert !passphrase.anagram_valid?
  end
end
