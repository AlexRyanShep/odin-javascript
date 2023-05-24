# frozen_string_literal: false

def caesar_cipher (string, dif)
  # basic_increase
  ascii = string.bytes
  ascii.map! do |char|

    case char

    when 65..90
      char += dif
      char = 64 + (char - 90) if char > 90
    when 97..122
      char += dif
      char = 96 + (char - 122) if char > 122
    end
    char
  end
  ascii.pack('c*')
end

puts caesar_cipher("What a string!", 5)


