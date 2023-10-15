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

  it "formats a date as ISO-8601" do
    expect(Transformer.new({"dob" => "01/01/2000"}).dob).to eq(Date.new(2000, 1, 1).iso8601)
  end

  it "formats a phone number as E.164" do
    expect(Transformer.new({"phone_number" => "(303) 555-4202)"}).phone_number).to eq("+13035554202")
  end
end
