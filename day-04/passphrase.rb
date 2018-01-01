require_relative 'anagram'

class Passphrase
  include Anagram

  def initialize(phrase)
    @words = phrase.strip.split(' ')
  end

  def duplicate_valid?
    @words == @words.uniq
  end

  def anagram_valid?
    @words == Anagram.remove_anagrams(@words)
  end
end
