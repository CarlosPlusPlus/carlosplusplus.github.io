---
layout: post
title: "Linked Lists and Ruby"
date: 2013-08-08 15:24
comments: true
categories: datastructures flatironschool oop ruby
---

One of the most talked about data structures in Computer Science is the **Linked List**.  

So, what is a **Linked List** and how can we implement it in Ruby?

## What is a Linked List?

As defined by **[Wikipedia](https://en.wikipedia.org/wiki/Linked_list)**, a **Linked List** (LL) is:

> Data structure consisting of a group of nodes which together represent a sequence.

In the simplest implementation of a LinkedList, each node has the following:

> **value** = represents the value of the node (e.g. integer, Class, etc.)

> **next** = pointer to the next value in the sequence.

In addition, 

## Ruby Implementation

TEXT HERE

### Node Class

Here is my implementation of the `Node` class:

```ruby

# Define a Node class that holds the following:
# 	=> next	: stores the next Node in the Linked List. 
# 	=> value: stores the value of the current list element.

class Node
	attr_accessor :value, :next

	def initialize(value)
		@value = value
	end
end

```

### LinkedList Class

Here is my implementation of the `LinkedList` class:

```ruby

# Define a LinkedList class the holds the following:
# 	=> head	: pointer to the head of the Linked List. 
# 	=> tail	: pointer to the tail of the Linked List. 

class LinkedList
	attr_accessor :head, :tail

	# Initialize head and tail to same initial Node.
	def initialize (head)
		raise "LinkedList must be initialized with a Node." unless head.is_a?(Node)
			
		@head = head
		@tail = head
	end

	# Insert Node after the tail of the LinkedList.
	def insert(node)
		@tail.next = node
		@tail 		 = @tail.next
	end

	# Print out all the values of the LinkedList in order.
	def print
		current_node = @head
		
		while current_node != nil
			puts "\tLL Node Value = #{current_node.value}"
			current_node = current_node.next
		end
	end

	# Iterate through LinkedList and perform block actions.
	def iterate
		if block_given?
			current_node = @head

			while current_node != nil
				yield current_node.value
				current_node = current_node.next
			end
		else
			print
		end
	end
end

```

### TestBench

Here is a quick test bench I wrote to test functionality:

```ruby

puts "\nCreating LinkedList of 5 Node elements with values 1-5.\n"

h 	 = Node.new(1)
list = LinkedList.new(h)

(2..5).each {|n| list.insert(Node.new(n)) }

puts "\nCurrent values contained in LinkedList:\n"

list.print

puts "\n"
puts "Values of head and tail of LinkedList:\n"

puts "\tValue of LL Head = #{list.head.value}"
puts "\tValue of LL Tail = #{list.tail.value}"

puts "\n"
puts "Iterating through LinkedList without a block prints the list.\n"

list.iterate

puts "\n"
puts "Iterating through the LinkedList with a block runs the block on each element.\n"

list.iterate {|n| puts "\tLL Node Value squared = #{n ** 2}"}

puts "\n"

```

Here is the output from the test bench:

IMAGE from TESTBENCH

## More with Linked Lists

The fun doesn't end here!  

Check out these other implementations of Linked Lists:

IMAGE 1  
IMAGE 2  
IMAGE 3  

