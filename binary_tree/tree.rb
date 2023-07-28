# frozen_string_literal: true

# Sorted binary tree of nodes
class Tree
  def initialize(values)
    @initial_values = values
    @root = build_tree(values.uniq.sort)
  end

  def build_tree(values, parent = nil)
    curr_node = Node.new(value: values.delete_at((values.count / 2).floor), parent:)

    left, right = values.each_slice((values.count.to_f / 2).ceil).to_a

    set_left(curr_node, left)
    set_right(curr_node, right)

    curr_node
  end

  def set_right(curr_node, right)
    curr_node.right = if right.nil?
                        nil
                      else
                        right.size == 1 ? Node.new(value: right[0], parent: curr_node) : build_tree(right, curr_node)
                      end
  end

  def set_left(curr_node, left)
    curr_node.left = if left.nil?
                       nil
                     else
                       left.size == 1 ? Node.new(value: left[0], parent: curr_node) : build_tree(left, curr_node)
                     end
  end

  def insert(value, curr_node = @root)
    value = value.to_i
    return nil if @initial_values.include?(value)

    if value < curr_node.value
      if curr_node.left.nil?
        curr_node.left = Node.new(value:, parent: curr_node)
      else
        insert(value, curr_node.left)
      end
    elsif curr_node.right.nil?
      curr_node.right = Node.new(value:, parent: curr_node)
    else
      insert(value, curr_node.right)
    end
  end

  def find(value, curr_node = @root)
    if curr_node.nil?
      nil
    elsif value == curr_node.value
      curr_node
    elsif value > curr_node.value
      nil if curr_node.right.nil? || curr_node.right.leaf?
      find(value, curr_node.right)
    else
      nil if curr_node.left.nil? || curr_node.left.leaf?
      find(value, curr_node.left)
    end
  # rescue NoMethodError
  #   nil
  end

  def delete(value)
    target = find(value)
    return if target.nil?

    if target.count_children.zero?
      leaf_delete(target)
    elsif target.count_children == 1
      one_child_delete(target)
    else
      two_child_delete(target)
    end
  end

  def leaf_delete(target)
    if target.parent.right == target
      target.parent.right = nil
    else
      target.parent.left = nil
    end
  end

  def one_child_delete(target)
    parent = target.parent
    child = target.left.nil? ? target.right : target.left

    if parent.left == target
      parent.left = child
    else
      parent.right = child
    end

    child.parent = parent
  end

  def two_child_delete(target)
    inorder_arr = inorder(target).sort
    inorder_arr.delete(target.value)
    inorder_successor = nil
    inorder_arr.each do |elem|
      if elem > target.value
        inorder_successor = find(elem)
        break
      end
    end

    tmp = inorder_successor.value
    delete(tmp)
    target.value = tmp
  end

  def inorder(origin = @root, &block)
    @return_array = []
    inorder_inner(origin, &block)
    @return_array unless block_given?
  end

  def inorder_inner(origin, &block)
    inorder_inner(origin.left, &block) unless origin.left.nil?
    if block_given?
      block.call(origin.value)
    else
      @return_array << origin.value
    end
    inorder_inner(origin.right, &block) unless origin.right.nil?
  end

  def preorder(origin = @root, &block)
    @return_array = []
    preorder_inner(origin, &block)
    @return_array unless block_given?
  end

  def preorder_inner(origin, &block)
    if block_given?
      block.call(origin.value)
    else
      @return_array << origin.value
    end
    preorder_inner(origin.left, &block) unless origin.left.nil?
    preorder_inner(origin.right, &block) unless origin.right.nil?
  end

  def postorder(origin = @root, &block)
    @return_array = []
    postorder_inner(origin, &block)
    @return_array unless block_given?
  end

  def postorder_inner(origin, &block)
    postorder_inner(origin.left, &block) unless origin.left.nil?
    postorder_inner(origin.right, &block) unless origin.right.nil?
    if block_given?
      block.call(origin.value)
    else
      @return_array << origin.value
    end
  end

  def level_order(origin = @root, &block)
    origin = find(origin) if origin.is_a? Integer
    @return_array = []
    @height = -1

    level_origin_inner([origin], &block)

    @return_array unless block_given?
  end

  def level_origin_inner(queue, &block)
    return if queue.count.zero? || queue.nil? || queue[0].nil?

    next_level = []
    @height += 1

    queue.each do |node|

      next_level = populate_queue(node, next_level)
      if block_given?
        block.call(node.value)
      else
        @return_array << node.value
      end
    end

    level_origin_inner(next_level, &block)

  end

  def populate_queue(node, queue)
    return [] if node.nil?

    queue << node.left unless node.left.nil?
    queue << node.right unless node.right.nil?
    queue
  end

  def height(origin)
    level_order(origin)
    @height
  end

  def depth(target)
    level_order { |node| return @height if node == target }
  end

  def balanced?
    level_order do |node|
      node = find(node)
      return false unless [1, 0, -1].include?(height(node.left) - height(node.right))
    end
    true
  end

  def rebalance
    current_pages = []
    level_order { |node| current_pages << node }
    @root = build_tree(current_pages.sort)
  end

  def pretty_print(node = @root, prefix = '', is_left: true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", is_left: false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", is_left: true) if node.left
  end
end
