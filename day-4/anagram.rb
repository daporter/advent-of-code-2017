module Anagram
  def self.remove_anagrams(words)
    return [] if words.empty?

    first = words[0]
    cleaned_rest = remove_anagrams(words[1..-1])
    [first] + remove_anagrams_of(first, cleaned_rest)
  end

  def self.remove_anagrams_of(word, words)
    words.find_all do |candidate|
      !anagram_of?(candidate, word)
    end
  end

  def self.anagram_of?(word, other_word)
    word.chars.sort == other_word.chars.sort
  end
end
