# frozen_string_literal: false

def caesar_cipher (string, dif)
  # basic_increase
  ascii = string.bytes
  ascii.map! do |char|
    char.to_i
    case char
    when 65..90

      char += dif

      if char > 90
        remainder = char - 90
        char = 64 + remainder
      end


    when 97..122

      char += dif

      if char > 122
        remainder = char - 122
        char = 96 + remainder
      end
    end
    char

  end
  ascii.pack('c*')
end

puts caesar_cipher("What a string!", 5)


