# frozen-string-literal: true

# Represents the full list
class LinkedList
  attr_accessor :head, :tail

  def initialize
    @head = nil
    @tail = nil
    @number_of_nodes = 0
  end

  def append(value)
    new_node = Node.new(value)
    @number_of_nodes += 1
    if @tail
      @tail.next_node = new_node
    else
      @head = new_node
    end
    @tail = new_node
  end

  def prepend(value)
    new_node = Node.new(value, @head)
    @number_of_nodes += 1
    @tail ||= new_node
    @head = new_node
  end

  def size
    @number_of_nodes
  end

  def at(index)
    return 'Erroneous input' unless index <= size - 1 && index >= 0
    
    if index.zero?
      @head
    else
      target_node = @head
      index.downto(1) { target_node = target_node.next_node }
      target_node
    end
  end

  def pop
    if @tail
      @number_of_nodes -= 1
      @tail = self.at(@number_of_nodes - 1)
      @tail.next_node = nil
    else
      'There are no elements in the list.'
    end
  end

  def contains?(value)
    current_node = @head
    @number_of_nodes.times do
      return true if current_node.value == value

      current_node = current_node.next_node
    end
    false
  end

  def find(value)
    if self.contains?(value)
      index = 0
      current_node = @head
      @number_of_nodes.times do
        return index if current_node.value == value

        index += 1
        current_node = current_node.next_node
      end
    end
    nil
  end

  def to_s
    output = ''
    current_node = @head
    @number_of_nodes.times do
      output += "( #{current_node.value} ) -> "
      current_node = current_node.next_node
    end
    output += 'nil'
  end

  # Extra credit
  def insert_at(value, index)
    @number_of_nodes += 1
    node_to_replace = self.at(index)
    new_node = Node.new(value, node_to_replace)
    if index != 0
      previous_node = self.at(index - 1)
      previous_node.next_node = new_node
    else
      @head = new_node
    end
  end

  # Extra credit
  def remove_at(index)
    @number_of_nodes -= 1
    node_to_remove = self.find(index)
    if index != 0
      previous_node = self.at(index - 1)
      previous_node.next_node = node_to_remove.next_node
    else
      next_node = self.at(index + 1)
      @head = next_node
    end
  end
end

# Represents a single node
Node = Struct.new(:value, :next_node)
