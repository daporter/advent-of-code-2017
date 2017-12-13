require_relative 'captcha'

if ARGV.length < 1
  puts "Usage: #{$0} <input-file>"
  exit 1
end

digits = File.read(ARGV[0]).chomp
solution = Captcha.new(digits).solve

puts "The solution to the captcha is: #{solution}"
