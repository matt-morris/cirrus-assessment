# frozen_string_literal: true

require "csv"
require "date"

module Importa
  class BaseTransformer
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

    def parse_date(value)
      [
        ["%m-%d-%y", /^\d{1,2}-\d{1,2}-\d{2}$/], # 1-11-88
        ["%m/%d/%y", /^\d{1,2}\/\d{1,2}\/\d{2}$/], # 01/11/88
        ["%m-%d-%Y", /^\d{1,2}-\d{1,2}-\d{4}$/], # 01-11-1988
        ["%m/%d/%Y", /^\d{1,2}\/\d{1,2}\/\d{4}$/], # 01/11/1988
        ["%m-%d-%y", /^\d{1,2}-\d{1,2}-\d{4}$/], # 01-11-1988
        ["%m/%d/%y", /^\d{1,2}\/\d{1,2}\/\d{2}$/], # 01/11/88
        ["%d-%m-%y", /^\d{1,2}-\d{1,2}-\d{2}$/], # 11-01-88
        ["%d/%m/%y", /^\d{1,2}\/\d{1,2}\/\d{2}$/], # 11/01/88
        ["%d-%m-%Y", /^\d{1,2}-\d{1,2}-\d{4}$/], # 11-01-1988
        ["%d/%m/%Y", /^\d{1,2}\/\d{1,2}\/\d{4}$/], # 11/01/1988
        ["%Y-%m-%d", /^\d{4}-\d{2}-\d{2}$/], # 1988-01-11
        ["%d-%m-%Y", /^\d{1,2}-\d{1,2}-\d{4}$/], # 11-01-1988
        ["%Y/%m/%d", /^\d{4}\/\d{2}\/\d{2}$/], # 1988/01/11
        ["%d/%m/%Y", /^\d{1,2}\/\d{1,2}\/\d{4}$/], # 11/01/1988
        ["%B %d, %Y", /^[A-Za-z]+ \d{1,2}, \d{4}$/], # January 11, 1988
        ["%b %d, %Y", /^[A-Za-z]{3} \d{1,2}, \d{4}$/], # Jan 11, 1988
        ["%d %B, %Y", /^\d{1,2} [A-Za-z]+, \d{4}$/], # 11 January, 1988
        ["%d %b, %Y", /^\d{1,2} [A-Za-z]{3}, \d{4}$/] # 11 Jan, 1988
      ].each do |format, regex|
        next unless value.to_s.match?(regex)
        return Date.strptime(value.to_s, format).iso8601
      rescue ArgumentError
        next
      rescue
        nil
      end
      nil
    end
  end
end
