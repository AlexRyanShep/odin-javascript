# frozen_string_literal: true

require 'csv'
require 'google/apis/civicinfo_v2'
require 'erb'

def generate_form_letter(id, letter)
  filename = "event_manager/output/thanks_#{id}.html"

  File.open(filename, 'w') do |file|
    file.puts letter
  end
end
def legislators_by_zipcode(zip)
  civic_info = Google::Apis::CivicinfoV2::CivicInfoService.new
  civic_info.key = 'AIzaSyClRzDqDh5MsXwnCWi0kOiiBivP6JsSyBw'

  begin
    civic_info.representative_info_by_address(address: zip, levels: 'country',
                                              roles: %w[legislatorUpperBody legislatorLowerBody]).officials
  rescue StandardError
    'Unable to retrieve representatives. You can find your representatives by visiting www.commoncause.org/take-action/find-elected-officials'
  end
end

def clean_zipcode(zipcode)
  zipcode.to_s.rjust(5, '0')[0..4]
end

puts 'Event Manager Initialized!'
filename = 'event_manager/event_attendees.csv'
template_letter = File.read('event_manager/form_letter.erb')
erb_template = ERB.new template_letter

contents = CSV.open(filename, headers: true, header_converters: :symbol)
contents.each do |row|
  id = row[0]
  name = row[:first_name]
  zipcode = clean_zipcode(row[:zipcode])
  legislators = legislators_by_zipcode(zipcode)

  personal_letter = erb_template.result(binding)

  generate_form_letter(id, personal_letter)

end
