require_relative 'spreadsheet'

string = File.read('input.txt')
checksum = Spreadsheet.new(string).checksum

puts "The checksum is: #{checksum}"
