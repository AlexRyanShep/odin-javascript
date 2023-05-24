# frozen_string_literal: false

dictionary = ['below', 'down', 'go', 'going', 'horn', 'how', 'howdy', 'it', 'i', 'low', 'own', 'part', 'partner', 'sit']

def substrings(string, dictionary)
  results = Hash.new(0)

  dictionary.each do |substring|
    results[substring] += string.downcase.scan(substring).length
  end
  puts results
end

substrings("Howdy partner, sit down! How's it going?", dictionary)
