require "csv"
require_relative "transformer"

file = File.read("input.csv").sub!("\xEF\xBB\xBF", "")
input = CSV.parse(file, headers: true)

CSV.open("output.csv", "w", headers: true) do |csv|
  csv << input.headers

  input.each do |row|
    transformer = Transformer.new(row)

    row["first_name"] = transformer.first_name
    row["last_name"] = transformer.last_name
    row["dob"] = transformer.dob
    row["member_id"] = transformer.member_id
    row["effective_date"] = transformer.effective_date
    row["expiry_date"] = transformer.expiry_date
    row["phone_number"] = transformer.phone_number

    csv << row
  end
end
