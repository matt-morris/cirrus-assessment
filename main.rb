require "csv"
require_relative "transformer"

file = File.read("input.csv").sub!("\xEF\xBB\xBF", "")
input = CSV.parse(file, headers: true)

CSV.open("output.csv", "w") do |csv|
  csv << input.headers

  Transformer.transform_batch(input).each do |row|
    csv << row
  end
end
