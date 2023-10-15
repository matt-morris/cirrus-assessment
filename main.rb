require "csv"
require "date"

file = File.read("input.csv").sub!("\xEF\xBB\xBF", "")
input = CSV.parse(file, headers: true)

class Transformer
  def initialize(row)
    @row = row
  end

  def first_name
    @row["first_name"]&.strip
  end

  def last_name
    @row["last_name"]&.strip
  end

  def dob
    Date.parse(@row["dob"]).iso8601
  rescue
    nil
  end

  def member_id
    @row["member_id"]
  end

  def effective_date
    Date.parse(@row["effective_date"]).iso8601
  rescue
    nil
  end

  def expiry_date
    Date.parse(@row["expiry_date"]).iso8601
  rescue
    nil
  end

  def phone_number
    @row["phone_number"].gsub(/\D/, "")
  rescue
    nil
  end
end

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
