# frozen_string_literal: true

# Node holding data
class Node
  include Comparable
  attr_accessor :value, :parent, :left, :right

  def initialize(value: nil, parent: nil, left: nil, right: nil)
    @value = value
    @parent = parent
    @left = left
    @right = right
  end

  def <=>(other)
    @value <=> other.value
  rescue NoMethodError
    nil
  end

  def count_children
    count = 0
    count += 1 unless @left.nil?
    count += 1 unless @right.nil?
    count
  end

  def leaf?
    true if count_children.zero?
    false
  end
end
