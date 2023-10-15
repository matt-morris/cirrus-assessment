# frozen_string_literal: true

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

RSpec.describe Importa do
  it "has a version number" do
    expect(Importa::VERSION).not_to be nil
  end

  it "strips whitespace from stings" do
    expect(Transformer.new({"first_name" => " John "}).first_name).to eq("John")
  end
end
