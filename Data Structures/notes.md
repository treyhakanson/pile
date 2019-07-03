# Data Structures

## Overview
- Provide a way of organizing data that is stored in a computer or database
- Different types of data structures represent different ways of storing data
- There are many kinds of data structures, each with different strengths and weaknesses
	- some are fast at storing/recording data, while others are better and searching and retreiving data
- Correct use of data structures can have a big impact on speed, performance, and overall efficiency



## Big "O" Notation
- tells us how much slower an algorithm will run as it's input size grows
- *O(1)* constant runtime; the algorithm's runtime does not change as the size of the input increases
- *O(n)* linear runtime; the algorithm's runtime increases constantly with the size of the input (1 loop function)
- *O(n^2)* exponential runtime; the algorithm's runtime increases exponentially as the size of the inputs increases (2 loop function)
- *O(log n)* logarithmic runtime; the algorithm's runtime increases logarithmically as the size of the input increases, meaning that at some point the runtime levels out to a constant time regardless of input size
	- A binary search, for example, has a logarithmic runtime; this is because each decision made at a node cuts the remaining data set in half. Think of it like searching through a physical dictionary, if you're looking for the word "house", you would randomly open the dictionary to about the middle, realize you were at "M", and then go back a little bit, ignoring the forward half, repeating this process until dialed in on the correct page.



## Linked Lists

### Overview
- Consist of linked nodes, where each node represents some piece of data
- Store data quickly, slow for retrieving data
- Two types of linked lists, singly and doubly linked lists
	- *singly linked lists* each node contains only a reference to the next node
	- *soubly linked lists* each node contains a reference to both the next /and/ the previous node
- In order to function correctly, a linked list only needs to know of 2 nodes; the head (first) node and the tail (last) node
- basic performable operations of a linked list:
	- add a node before the head (becomes the new head)
	- add a node after the tail (becomes the new tail)
	- remove the head (next node becomes the head)
	- remove the tail (previous node becomes the tail)
	- search for a given value in the list

### Time Complexity
- adding/removing O(1)
- searching O(n)

### Use Cases
- good for circular references
- good for low level programming where memory management is key, because they allow for large sets of data to be stored in small chunks and be spread over physical memory however is seen fit; the chunks don't have to be stored physically near each other, they just have to contain pointers to the next node



## Hash Table
- Fast to read data, but slower to write than a linked list

### Overview
- essentially a table of pre-determined length consisting of buckets of a key and value (key value pair)
- hash tables are typically considered to have constant time lookup/insertion
	- not 100% true, because if a collison occurs (two values are hashed to the same value), that bucket becomes a linked list and the node attempting to be inserted is linked after the node already there. However, if the hash table is setup well with a variety of buckets and a good hashing function, this will not happen often, meaning that the time complexity is approximaty constant
- basic performable operations
	- hashing method
	- inserting data
	- retrieving data

### Time Complexity
- adding/inserting O(1)

### Uses and Performance
- very performant; hash tables have constant time lookup and insertion (approximately, assuming no to minor collision instances)
- hash tables are often used to store general data, such as users, emails, etc.
- one drawback is that data is stored somewhat randomly due to hashing, so unlike a linked list or binary search tree, no references to other pieces of data are stored with each node (barring collisions)




## Binary Search Trees

### Overview
- Consists of Nodes, each of which has between 0 and 2 child nodes (left leaf, right leaf are the terms for the child nodes)
- The tree is constructed based on some arbitrary binary decision; For example, in the case of a binary search tree composed of numbers, the left leaf could be a number lower than or equal to the parent, and the right lead could be a number greater than the parent. This pattern would permeate all the way down the tree.
- Each node of a binary search tree is itself a smaller binary search tree, since it has all the same properties (0-2 children, same rule dictating child placement, etc.)
- basic operations
	- insert (to add a node)
	- contains (to detect the presence of a particular value)
	- depth first traversal (traverse the tree all the way down for each node at a given level before moving on to the next node at that level)
	- breadth first traversal  (traverse the tree across all nodes at each level before moving down to the next level)

### Use Cases and Performance
- Very fast to search through and retrieve data from, so good for various searching purposes
- Also fast to insert and delete data, because that essentially involves searching the tree to find a particular node to delete/add on to
- One pitfall of binary search trees is having unbalanced trees; trees where most nodes have only a right or a left node, making branches essentially linked lists
- Could be used for things like dictionaries, phone books, etc.
	- an interesting case is finding users based on a numerical id
















