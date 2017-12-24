class Passphrase
  def initialize(phrase)
    @words = phrase.strip.split(' ')
  end

  def valid?
    @words == @words.uniq
  end
end
