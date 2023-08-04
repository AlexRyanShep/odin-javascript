# frozen_string_literal: false
module Caesar
  module Cipher
    def caesar_cipher (string, dif)
      # basic_increase
      ascii = string.bytes
      ascii.map! do |char|

        case char

        when 65..90
          char += dif
          if dif.positive?
            char = 64 + (char - 90) until char <= 90
          else
            char = 90 + (char - 64) until char >= 65
          end
        when 97..122
          char += dif
          if dif.positive?
            char = 96 + (char - 122) until char <= 122
          else
            char = 122 + (char - 96) until char >= 97
          end

        end
        char
      end
      ascii.pack('c*')
    end
  end
end


