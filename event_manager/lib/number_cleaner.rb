# frozen_string_literal: true

require 'csv'

def clean_phone_number(number)
  number = number.delete(' ()-.')

  if number.length == 10
    number
  elsif number.length == 11 && number[0] == '1'
    number[1..10]
  else
    'Bad Number'
  end
end

filename = 'event_manager/event_attendees.csv'

contents = CSV.open(filename, headers: true, header_converters: :symbol)
contents.each do |row|
  phone_number = clean_phone_number(row[:homephone])

  puts phone_number
end
