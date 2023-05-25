# frozen_string_literal: true

def bubble(input_arr)

  offset = 2
  (0..input_arr.length - 2).each do |run|
    (0..input_arr.length - offset).each do |index|
      if input_arr[index] > input_arr[index + 1]
        input_arr[index], input_arr[index + 1] = input_arr[index + 1], input_arr[index]
      end
    end
    offset += 1
  end
  puts "Sorted Array: #{input_arr}"
end

input_arr = Array.new(20) { rand(1..99) }
puts "Initial Array: #{input_arr}"

bubble(input_arr)

