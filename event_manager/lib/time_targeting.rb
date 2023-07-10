# frozen_string_literal: true

# frozen_string_literal: true

require 'csv'
require 'Time'

def get_hour(time)
  Time.strptime(time, "%m/%d/%y %k:%M").hour
end

def get_day(time)
  Time.strptime(time, "%m/%d/%y %k:%M").strftime('%A')
end

filename = 'event_manager/event_attendees.csv'

contents = CSV.open(filename, headers: true, header_converters: :symbol)
time_counts = Hash.new(default = 0)
day_counts = Hash.new(default = 0)

contents.each do |row|
  signup_time = get_hour(row[:regdate])
  time_counts[signup_time] += 1

  signup_day = get_day(row[:regdate])
  day_counts[signup_day] += 1
end

time_counts.sort_by { |_, v| -v }.each do |hour, occurrences|
  puts "#{hour} hrs appears #{occurrences} times."
end

day_counts.sort_by { |_, v| -v }.each do |day, occurrences|
  puts "#{day} appears #{occurrences} times."
end
