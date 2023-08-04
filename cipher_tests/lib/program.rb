# frozen_string_literal: true

require_relative 'caesar'
include Caesar::Cipher

p caesar_cipher('hello world', -7)