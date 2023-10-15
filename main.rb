require "csv"
require "date"

input = CSV.read("input.csv", headers: true)

# headers:
# ["first_name", "last_name", "dob", "member_id", "effective_date", "expiry_date", "phone_number"]

CSV.open("output.csv", "w", headers: true) do |csv|
  csv << input.headers

  input.each do |row|
    row["first_name"] = begin
      row["first_name"]&.strip
    rescue
      row["first_name"]
    end
    row["last_name"] = begin
      row["last_name"]&.strip
    rescue
      row["last_name"]
    end
    row["dob"] = begin
      Date.parse.call(row["dob"]).iso8601
    rescue
      row["dob"]
    end
    row["member_id"] = begin
      row["member_id"]&.strip
    rescue
      row["member_id"]
    end
    row["effective_date"] = begin
      Date.parse.call(row["effective_date"]).iso8601
    rescue
      row["effective_date"]
    end
    row["expiry_date"] = begin
      Date.parse.call(row["expiry_date"]).iso8601
    rescue
      row["expiry_date"]
    end
    row["phone_number"] = begin
      row["phone_number"]&.gsub(/[^0-9]/, "")
    rescue
      row["phone_number"]
    end

    csv << row
  end
end
