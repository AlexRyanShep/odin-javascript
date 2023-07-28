# frozen_string_literal: true

require_relative 'tree'
require_relative 'node'

data_set = (Array.new(15) { rand(1..100)} )
tree = Tree.new(data_set)
tree.pretty_print
puts "Is this tree balanced?: #{tree.balanced?}"
puts "Nodes in level order: #{tree.level_order}"
puts "Nodes in pre-order: #{tree.preorder}"
puts "Nodes in post-order: #{tree.postorder}"
tree.insert(101)
tree.insert(120)
tree.insert(199)
tree.pretty_print
puts "Is this tree still balanced?: #{tree.balanced?}"
tree.rebalance
tree.pretty_print
puts "Is the tree balanced again?: #{tree.balanced?}"
puts "Nodes in level order: #{tree.level_order}"
puts "Nodes in pre-order: #{tree.preorder}"
puts "Nodes in post-order: #{tree.postorder}"