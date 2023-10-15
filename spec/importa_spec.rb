# frozen_string_literal: true

class Transformer < Importa::BaseTransformer
  field :first_name
  field :last_name
  field :dob, :date
  field :member_id
  field :effective_date, :date
  field :expiry_date, :date, optional: true
  field :phone_number, :phone, optional: true
end

RSpec.describe Importa do
  it "has a version number" do
    expect(Importa::VERSION).not_to be nil
  end

  it "strips whitespace from stings" do
    expect(Transformer.new({"first_name" => " John "})["first_name"]).to eq("John")
  end

  it "formats a date as ISO-8601" do
    expect(Transformer.new({"dob" => "01/01/2000"})["dob"]).to eq(Date.new(2000, 1, 1).iso8601)
  end

  it "formats a phone number as E.164" do
    expect(Transformer.new({"phone_number" => "(303) 555-4202)"})["phone_number"]).to eq("+13035554202")
  end

  it "requires fields to be present by default" do
    input = {"first_name" => "John", "dob" => "01/01/2000", "member_id" => "123", "effective_date" => "01/01/2020", "expiry_date" => "01/01/2021", "phone_number" => "(303) 555-4202)"}
    t = Transformer.new(input)
    expect(t.valid?).to be_falsey
  end

  it "allows fields to be optional" do
    input = {"first_name" => "John", "last_name" => "Doe", "dob" => "01/01/2000", "member_id" => "123", "effective_date" => "01/01/2020", "phone_number" => "(303) 555-4202)"}
    t = Transformer.new(input)
    expect(t.valid?).to be_truthy
  end

  it "transforms all fields in order" do
    input = {"first_name" => "John", "last_name" => "Doe", "dob" => "01/01/2000", "member_id" => "123", "effective_date" => "01/01/2020", "expiry_date" => "01/01/2021", "phone_number" => "(303) 555-4202)"}
    expected = ["John", "Doe", "2000-01-01", "123", "2020-01-01", "2021-01-01", "+13035554202"]
    output = Transformer.new(input).transform

    expect(output).to eq(expected)
  end

  it "transforms batches of records" do
    input = [
      {"first_name" => "John", "last_name" => "Doe", "dob" => "01/01/2000", "member_id" => "123", "effective_date" => "01/01/2020", "expiry_date" => "01/01/2021", "phone_number" => "(303) 555-4202)"},
      {"first_name" => "Jane", "last_name" => "Doe", "dob" => "01/01/2000", "member_id" => "123", "effective_date" => "01/01/2020", "expiry_date" => "01/01/2021", "phone_number" => "(303) 555-4202)"}
    ]
    expected = [
      ["John", "Doe", "2000-01-01", "123", "2020-01-01", "2021-01-01", "+13035554202"],
      ["Jane", "Doe", "2000-01-01", "123", "2020-01-01", "2021-01-01", "+13035554202"]
    ]
    output = Transformer.transform_batch(input)
    expect(output).to eq(expected)
  end
end
