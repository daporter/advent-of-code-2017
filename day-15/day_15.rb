require_relative 'judge'

judge = Judge.new(883, 879, 40_000_000)
puts "There are #{judge.match_count} matches"
