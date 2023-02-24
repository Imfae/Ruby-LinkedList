## Node class
class Node
  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
  attr_accessor :value, :next_node
end