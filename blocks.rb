# frozen_string_literal: false

transactions = [10, -15, 25, 30, -24, -70, 999]

def transaction_statement(transactions)
  formatted_transactions = []
  transactions.each do |transaction|
    formatted_transactions << yield(transaction)
  end

  p formatted_transactions
end

transaction_statement(transactions) do |transaction|
  '%0.2f' % transaction
end

my_name = ->(name) { puts "hello #{name}" }

my_name.call('tim')
my_name.('tim')
my_name['tim']
my_name.=== 'tim'

class Timmy
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def double_me
    @value *= 2
  end

  def to_i
    @value
  end

end


arr = [Timmy.new(1), Timmy.new(2), Timmy.new(3)]

p arr.map(&:double_me)

def run_block
  yield
  puts 'World'
end

run_block do
  puts 'Hello'
  return
end
