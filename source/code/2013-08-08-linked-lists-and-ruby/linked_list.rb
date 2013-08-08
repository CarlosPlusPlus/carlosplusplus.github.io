# Define a Node class that holds the following:
# 	=> next	: stores the next Node in the Linked List. 
# 	=> value: stores the value of the current list element.

class Node
	attr_accessor :value, :next

	def initialize(value)
		@value = value
	end

end

# Define a LinkedList class the holds the following:
# 	=> head	: pointer to the head of the Linked List. 
# 	=> tail	: pointer to the tail of the Linked List. 

class LinkedList
	attr_accessor :head, :tail

	def initialize (head)
		@head = head
		@tail = head
	end

	def insert(node)
		raise "shit" unless node.is_a?(Node)
		@tail.next = node
		@tail 		 = @tail.next
	end

	def print
		current_node = @head
		
		while current_node != nil
			puts "LL Node Value = #{current_node.value}"
			current_node = current_node.next
		end
	end

	def iterate
		current_node = @head

		while current_node != nil
			if block_given?
				yield current_node.value
			else
				puts "LL Node Value = #{current_node.value}"
			end
			current_node = current_node.next
		end
	end

end


# def optional
# 	puts 'A code block isn\'t required, but it\'s nice.'
# 	yield if block_given?
# 	puts 'I\'m happy either way, really.'
# end

#############
# TESTBENCH #
#############

a = Node.new(1)
b = Node.new(2)
c = Node.new(3)
d = Node.new(4)
e = Node.new(5)

list = LinkedList.new(a)

list.insert(b)
list.insert(c)
list.insert(d)
list.insert(e)

list.print

puts "\n"

puts "Value of LL Head = #{list.head.value}"
puts "Value of LL Tail = #{list.tail.value}"

puts "\n"

list.iterate

puts "\n"

list.iterate {|n| puts "LL Node Value squared = #{n ** 2}"}