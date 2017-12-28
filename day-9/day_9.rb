require_relative 'stream_processor'

stream = IO.read('input.txt')
sp = StreamProcessor.new(stream)

puts "The total score for all groups is #{sp.score}"
puts "The number of non-cancelled garbage characters is #{sp.garbage_chars_count}"
