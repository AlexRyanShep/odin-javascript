# frozen_string_literal: true

require_relative 'linked_list'
require_relative 'node'

linked_list = LinkedList.new(1)

linked_list.append(2)
linked_list.append(3)
linked_list.prepend(4)

puts "Head: #{linked_list.head.value}"
puts "Tail: #{linked_list.tail.value}"
puts "Size: #{linked_list.size}"
puts "Head again from #at: #{linked_list.at(0).value}"
puts "At index 1: #{linked_list.at(1).value}"
puts "An error from #at(999): #{linked_list.at(999)}"
puts "Popped tail: #{linked_list.pop}"
puts "New Size: #{linked_list.size}"
puts "New tail: #{linked_list.tail.value}"
puts "List contains the value 2: #{linked_list.contains?(2)}"
puts "List no longer contains the value 3: #{linked_list.contains?(3)}"
puts "Value 1 is at index 1: #{linked_list.find(1)}"
puts "Value 4 is at index 0: #{linked_list.find(4)}"

empty_list = LinkedList.new()
two_list = LinkedList.new(1, 2)
six_list = LinkedList.new(1, 2, 3, 4, 5, 6)

puts "Original (3): #{linked_list.to_s}"
puts "Empty: #{empty_list.to_s}"
puts "Two: #{two_list.to_s}"
puts "Six: #{six_list.to_s}"

linked_list.insert_at(17, 3)
puts linked_list.to_s

linked_list.remove_at(2)
puts linked_list.to_s
linked_list.remove_at(2)
puts linked_list.to_s



