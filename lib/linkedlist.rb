require_relative 'node'

## LinkedList class
class LinkedList
  def initialize
    @head = Node.new
  end
  attr_reader :head

  def append(value)
    if @head.value.nil?
      @head.value = value
    else
      list_iterator.next_node = Node.new(value)
    end
  end

  def prepend(value)
    @head = Node.new(value, @head)
  end

  def size
    length = 1
    list_iterator { length += 1 }
    length
  end
  
  def tail
    list_iterator
  end

  def at(index)
    list_iterator do |current_node, current_index|
      return current_node if current_index == index
    end
  end

  def pop
    at(size - 2).next_node = nil
  end

  def contains?(input, current_node = @head)
    if current_node.nil?
      false
    elsif current_node.value == input
      true
    else
      contains?(input, current_node.next_node)
    end
  end

  def find(input)
    list_iterator do |current_node, current_index|
      return current_index if current_node.value == input
    end
    nil
  end

  def to_s
    list = ''
    list_iterator do |current_node|
      list << "( #{current_node.value} ) -> "
    end
    list << "( #{list_iterator.value} ) -> nil\n"
  end

  def insert_at(input, index)
    if index.zero?
      prepend(input)
    else
      list_iterator do |current_node, current_index|
        return current_node.next_node = Node.new(input, current_node.next_node) if current_index == (index - 1)
      end
    end
  end

  def remove_at(index)
    if index.zero?
      @head = @head.next_node
    else
      list_iterator do |current_node, current_index|
        return current_node.next_node = current_node.next_node.next_node if current_index == (index - 1)
      end
    end
  end

  private

  def list_iterator
    current_node = @head
    current_index = 0
    until current_node.next_node.nil?
      yield(current_node, current_index) if block_given?
      current_node = current_node.next_node
      current_index += 1
    end
    current_node
  end
end
