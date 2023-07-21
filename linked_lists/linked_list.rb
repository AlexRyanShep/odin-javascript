# frozen_string_literal: false

# Ordered list of Nodes
class LinkedList

  def initialize(*nodes)
    case nodes.length
    when 0
      @head = nil
      @tail = nil
    when 1
      @head = new_node(nodes[0])
      @tail = nil
    else
      nodes.each do |node|
        append(node)
      end
    end

  end

  def new_node(value, next_node = nil)
    Node.new(value, next_node)
  end

  def append(value)
    node = new_node(value)
    if @head.nil?
      @head = node
      return
    end

    if @tail.nil?
      @tail = node
      @head.next_node = @tail
    else
      @tail.next_node = node
      @tail = node
    end
  end

  def prepend(value)
    node = new_node(value)
    node.next_node = @head
    @head = node
  end

  def head
    @head
  end

  def tail
    @tail
  end

  def size
    return 0 if @head.nil?

    counter = 1
    curr_node = @head.next_node

    until curr_node.nil?
      counter += 1
      curr_node = curr_node.next_node
    end

    counter
  end

  def at(index)
    return nil if index > size - 1

    ind_cnt = 0
    curr_node = @head

    until ind_cnt == index
      curr_node = curr_node.next_node
      ind_cnt += 1
    end
    curr_node
  end

  def pop
    new_tail = @head
    tail_value = @tail.value

    new_tail = new_tail.next_node until new_tail.next_node == @tail

    @tail = new_tail
    @tail.next_node = nil
    tail_value
  end

  def contains?(value)
    curr_node = @head

    until curr_node.nil?
      return true if curr_node.value == value

      curr_node = curr_node.next_node
    end

    false
  end

  def find(value)
    index = 0
    curr_node = @head

    until curr_node.value == value
      index += 1
      curr_node = curr_node.next_node
    end

    index
  end

  def to_s

    return '( nil )' if @head.nil?

    curr_node = @head
    string = "( #{head.value} )"

    until curr_node == @tail
      curr_node = curr_node.next_node
      string << " -> ( #{curr_node.value} )"
    end

    string << ' -> ( nil )'
  end

  def insert_at(value, index)
    node = new_node(value)
    curr = at(index)
    pre = at(index - 1)

    pre.next_node = node
    if pre == @tail
      @tail = node
    else
      node.next_node = curr
    end
  end

  def remove_at(index)
    new_bef = at(index - 1)
    if at(index) == @tail
      new_bef.next_node = nil
      @tail = new_bef
    else
      new_bef.next_node = at(index + 1)
    end
  end

end


