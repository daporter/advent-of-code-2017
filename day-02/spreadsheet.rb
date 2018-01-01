class Spreadsheet
  def initialize(string)
    @table = Spreadsheet.to_table(string)
  end

  def checksum_differences
    Spreadsheet.sum(Spreadsheet.row_differences(@table))
  end

  def checksum_quotients
    Spreadsheet.sum(Spreadsheet.row_quotients(@table))
  end

  def self.to_table(string)
    rows = string.strip.split("\n")
    rows.map { |row| row.strip.split.map(&:to_i) }
  end

  def self.row_differences(table)
    table.map { |row| Spreadsheet.row_difference(row) }
  end

  def self.row_difference(row)
    row.max - row.min
  end

  def self.row_quotients(table)
    table.map { |row| Spreadsheet.row_quotient(row) }
  end

  def self.row_quotient(row)
    # We are guaranteed that exactly two numbers in a row evenly divide each
    # other.
    row.each do |numerator|
      row.each do |denominator|
        next if denominator == numerator
        return (numerator / denominator) if (numerator % denominator).zero?
      end
    end
  end

  def self.sum(row_differences)
    row_differences.reduce(0) { |sum, cell| sum + cell }
  end
end
