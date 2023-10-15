# Goal

## Usage

```bash
ruby main.rb
```

This will output `output.csv` and `report.txt` in the root directory.

## Tests

```bash
bundle exec rspec
```

## Notes

The transformer DSL I ended up with is pretty clean. I'm proud of this. It's probably overkill for a single file, but this gives a taste of how I would approach a larger project. Custom transformers can be quickly created using the `BaseTransformer`. It comes with a set of built-in formatters, but custom formatters can be added as well:

```ruby
class MyTransformer < BaseTransformer
  # Custom formatters
  format :shout, ->(value) { value.to_s.upcase }
  
  field :hello, :shout
end
```

If you don't need to make an entire new format, it's easy to augment a single field by passing it a block:

```ruby
class MyTransformer < BaseTransformer
  field :hello do |value|
    value.to_s.upcase
  end
end
```

---

Write a Ruby program that transforms raw data into a standardized format. The objective is to provide a valid .csv which allows the highest number of valid patient records
to be imported by the next stage of the process (not seen here). Some of the data will be invalid so there will be 2 output
files from your program, one of which will be the .csv and the other a report.txt file.

## Expectations

Try to time-box the exercise at around ~ 3 hours.
Keep this constraint in mind as you work, it's very possible that certain items don't get finished, try
to save a few minutes to summarize your efforts in a readme or email if this is the case.

## Requirements

- Parse the provided .csv containing patient information
- Clean / coerce data elements according to transform rules
- Provide instructions on how to run your program
- Your program should process and produce a .csv file (output.csv)
- Your program should ALSO produce a report file (report.txt) that summarizes the processing outcome (be creative in its contents)
- Use a recent stable version of Ruby MRI
- Please specify Ruby version and / or include a .tool-versions or .ruby-version file
- Limit libraries used in your implementation to ONLY [standard library](http://www.ruby-doc.org/stdlib/)
- Leverage Git, and demonstrate your workflow / style via commits
- Ensure there are tests included:
  - [RSpec](https://github.com/rspec/rspec)
  - [test-unit](https://github.com/test-unit/test-unit)
  - [minitest](https://github.com/seattlerb/minitest)
- Email your solution as a public Github repository link OR a .zip package to engineeringjobs@cirrusmd.com, include 'Software Engineer Take-Home' in the subject.

### Transform Rules

- Trim extra white space for all fields
- Transform phone_numbers to E.164 format (Please assume all numbers to be US e.g. +1)
- Transform ALL dates to ISO8601 format (YYYY-MM-DD)

### Validation Rules

- Phone Numbers must be E.164 compliant (country code + 10 numeric digits)
- first_name, last_name, dob, member_id, effective_date are ALL required for each patient

## Evaluation

The qualities we're looking for are:

- **Clarity**: is the code organized and structured well, is it easy to read and comprehend?
- **Maintainability**: if it had to be updated / extended how easy would that be?
- **Testability**: are the tests comprehensive and covering the appropriate use cases?

## Input

Please use the provided data file as the input for your solution.

- input.csv
  - Delimiter: `,`
  - Fields: `last_name`, `first_name`, `dob`, `member_id`, `effective_date`, `expiry_date`, `phone_number`

## Output

1. Running your tests should produce 0 errors or be explained in your readme
2. Running your script should produce a cleaned .csv (output.csv)
3. Running your program should also produce a summary report (report.txt)

## Questions

If you have questions about the instructions, please ask. We want you to be successful. If you have a question about how
to handle something that wasn't specifically addressed, make a decision and feel free to call it out in your
readme or email with your reasoning behind your decision. No right or wrong answers for these types of things.
