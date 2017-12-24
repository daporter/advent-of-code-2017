require_relative 'passphrase'

lines = IO.readlines('input.txt')
passphrases = lines.map { |line| Passphrase.new(line) }
num_valid = passphrases.find_all(&:valid?).count
puts "#{num_valid} passphrases are valid"
