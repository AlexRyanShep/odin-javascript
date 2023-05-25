# frozen_string_literal: false

require 'pry'

prices = [17,3,6,9,15,8,10 ,9,30]

def stock_picker(prices)

  best = {
    start: 0,
    end: 0,
    difference: 0
  }

  prices.each_with_index do |price, index|
    (index + 1..prices.length - 1).each do | n |
      diff = prices[n] - price
      if diff > best[:difference]
        best[:start] = index
        best[:end] = n
        best[:purchase_price] = price
        best[:sale_price] = prices[n]
        best[:difference] = diff
      end
    end
  end
  puts "Buying on day #{best[:start] + 1} for £#{best[:purchase_price]} and selling on day #{best[:end] + 1} for"\
       " £#{best[:sale_price]} gives you #{best[:difference]} profit"
end




stock_picker(prices)


