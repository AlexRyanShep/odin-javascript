# frozen_string_literal: true
require '../lib/caesar'
include Caesar::Cipher

describe "#caesar_cipher" do

  let(:simple) { 'hello world'}

  it 'encodes a simple phrase with a small positive offset' do
    expect(caesar_cipher(simple, 7)).to eql('olssv dvysk')
  end

  it 'encodes a simple phrase with a small negative offset' do
    expect(caesar_cipher(simple, -7)).to eql('axeeh phkew')
  end

  it 'encodes a simple phrase with a large positive offset' do
    expect(caesar_cipher(simple, 55)).to eql('khoor zruog')
  end

  it 'encodes a simple phrase with a large negative offset' do
    expect(caesar_cipher(simple, -55)).to eql('ebiil tloia')
  end

  it 'retains punctuation' do
    expect(caesar_cipher('hello world!', 7)).to eql('olssv dvysk!')
  end

  it 'retains numbers' do
    expect(caesar_cipher('h3llo world!', 7)).to eql('o3ssv dvysk!')
  end

  it 'retains capitalisation' do
    expect(caesar_cipher('Hello World!', 7)).to eql('Olssv Dvysk!')
  end

  it 'encodes a capitalised phrase with a small negative offset' do
    expect(caesar_cipher('Hello World!', -7)).to eql('Axeeh Phkew!')
  end

  it 'encodes a capitalised phrase with a large negative offset' do
    expect(caesar_cipher('Hello World!', -55)).to eql('Ebiil Tloia!')
  end
end
