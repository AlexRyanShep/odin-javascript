# spec/calculator_spec.rb
require './lib/calculator'

context Calculator do
  subject { Calculator.new }

  context '#add' do

    it 'returns the sum of two numbers' do
      expect(subject.add(5, b)).to eql(7)
    end

    it 'returns the sum of more than two numbers' do
      expect(subject.add(5, b ,c)).to eql(14)
    end
  end

  context '#multiply' do
    it 'multiplies two numbers' do
      expect(subject.multiply(2,7)).to eql(14)
    end
  end

end