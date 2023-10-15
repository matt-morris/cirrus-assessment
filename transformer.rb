require "csv"
require "date"

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
    parse_date(@row["dob"])
  end

  def member_id
    @row["member_id"]
  end

  def effective_date
    parse_date(@row["effective_date"])
  end

  def expiry_date
    parse_date(@row["expiry_date"])
  end

  def phone_number
    parse_phone_number(@row["phone_number"])
  end

  private

  def parse_phone_number(value)
    cleaned_value = value.to_s.gsub(/\D/, "").sub(/^1/, "")
    (cleaned_value.length == 10) ? "+1#{cleaned_value}" : nil
  end

    [
      "%m-%d-%y",
      "%m/%d/%y",
      "%m-%d-%Y",
      "%m/%d/%Y",
      "%m-%d-%y",
      "%m/%d/%y",
      "%d-%m-%y",
      "%d/%m/%y",
      "%d-%m-%Y",
      "%d/%m/%Y",
      "%Y-%m-%d",
      "%d-%m-%Y",
      "%Y/%m/%d",
      "%d/%m/%Y",
      "%B %d, %Y",
      "%b %d, %Y",
      "%d %B, %Y",
      "%d %b, %Y"
    ].each do |format|
      return Date.parse(date, format).iso8601
    rescue ArgumentError
      next
    rescue
      nil
    end
    nil
  end
end
