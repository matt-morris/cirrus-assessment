require "csv"
require_relative "transformer"

# we start by reading and parsing the input file
file = File.read("input.csv").sub!("\xEF\xBB\xBF", "") # remove BOM
input = CSV.parse(file, headers: true)

# open output file and write headers
CSV.open("output.csv", "w") do |csv|
  csv << input.headers

  # the transformer will handle the transformation of each row
  # and will return an array of values ready to shovel in.
  # it also tracks the process and writes a report file
  Transformer.transform_batch(input).each do |row|
    csv << row
  end
end
