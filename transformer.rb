require_relative "lib/importa"

class Transformer < Importa::BaseTransformer
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
end
