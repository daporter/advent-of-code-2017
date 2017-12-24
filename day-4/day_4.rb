require_relative 'passphrase'

lines = IO.readlines('input.txt')
passphrases = lines.map { |line| Passphrase.new(line) }
num_duplicate_valid = passphrases.find_all(&:duplicate_valid?).count
puts "#{num_duplicate_valid} passphrases are duplicate_valid"

num_anagram_valid = passphrases.find_all(&:anagram_valid?).count
puts "#{num_anagram_valid} passphrases are anagram_valid"
