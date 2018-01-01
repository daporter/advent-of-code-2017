require_relative 'spreadsheet'

string = File.read('input.txt')
spreadsheet = Spreadsheet.new(string)

puts "The differences checksum is: #{spreadsheet.checksum_differences}"
puts "The quotients checksum is: #{spreadsheet.checksum_quotients}"
