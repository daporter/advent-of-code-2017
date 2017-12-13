require_relative 'captcha_2'

digits = File.read('input-part-2.txt').chomp
solution = Captcha2.new(digits).solve

puts "The solution to the captcha is: #{solution}"
