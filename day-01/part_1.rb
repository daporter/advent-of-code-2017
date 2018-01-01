require_relative 'captcha_1'

digits = File.read('input-part-1.txt').chomp
solution = Captcha1.new(digits).solve

puts "The solution to the captcha is: #{solution}"
