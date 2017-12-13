class Spreadsheet
  def initialize(string)
    @table = to_table(string)
  end

  def checksum
    sum(row_differences)
  end

  private

  def to_table(string)
    rows = string.strip.split("\n")
    rows.map { |r| r.strip.split.map(&:to_i) }
  end

  def row_differences
    @table.map { |row| row.max - row.min }
  end

  def sum(row_differences)
    row_differences.reduce(0) { |sum, x| sum + x }
  end
end
