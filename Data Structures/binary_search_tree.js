// function constructor for the binary search tree
function BinarySearchTree(value) {
	this.value = value;
	this.left = null;
	this.right = null;
}

BinarySearchTree.prototype = {
	// function to insert a new node in the tree
	insert: function(value) {
		if (value <= this.value) {
			if (!this.left) 	this.left = new BinarySearchTree(value); 	// base case
			else 					this.left.insert(value); 						// recursive case
		} else { 																		// occurs when (value > this.value)
			if (!this.right) 	this.right = new BinarySearchTree(value); // base case
			else 					this.right.insert(value); 						// recursive case
		}
	},

	// function to check if a value exists in the tree
	contains: function(value) {
		if (value === this.value)  						return this; 								// the value matches; return the node
		else if (value < this.value && this.left) 	return this.left.contains(value); 	// the value doesn't match, but a left node exists and should be checked
		else if (value > this.value && this.right) 	return this.right.contains(value); 	// the value doesn't match, but a right node exists and should be checked
		else 														return null; 								// the value doesn't match, and there isn't an appropriate node to check
	},

	/**
		function that traverses the tree depth first; meaning that 
		it goes to the root of every node it encounters before moving
		to the next node
	*/
	depthFirstTraversal: function(action, order) { // action will be a method that takes in one 'value' parameter
		/**
			order has 3 possible values:
			- 1: in-order (least -> greatest)
			- 2: pre-order (run on each node as its passed over)
			- 3: post-order (the reverse of pre-order)
			- 4: reverse-order (greatest -> least);
		*/

		/**
			move through the left nodes, and when you hit the end,
			continue to move down the tree by working down the
			nearest right node
		*/
		if (!order === 4) { // the order is not reverse-order
			if (order === 2) action(this.value); // running the action here will just print each node's value as it is passed through 
			if (this.left) this.left.depthFirstTraversal(action, order);
			if (order === 1) action(this.value); // running the action here will wait until the branch is lowest node before invoking 'action'
			if (this.right) this.right.depthFirstTraversal(action, order);
			if (order === 3) action(this.value); // running the action here will result in the opposite of pre-order
		} else {
			// reverse-order requires a different block because the order of
			// the if statements must be flipped
			if (this.right) this.right.depthFirstTraversal(action, order);
			action(this.value); // running the action here will wait until the branch is highest node before invoking 'action'
			if (this.left) this.left.depthFirstTraversal(action, order);
		}
	},

	/**
		Breadth-first traversal is useful for establishing heirarchies
		because each row represents a subbordinate to the previous. Good
		for something like finding people of a specific status within an
		organization
	*/
	breadthFirstTraversal: function(action) { // action is the same as in above
		var queue = [this];

		while (queue.length) { // same as (queue.length > 0) since 0 when coerced to a bool is 'false'
			var node = queue.shift();
			action(node.value);
			if (node.left) queue.push(node.left);
			if (node.right) queue.push(node.right);
		}

	},

	min: function() {
		if (this.left) return this.left.min();
		else return this.value;
	},

	max: function() {
		if (this.right) return this.right.max();
		else return this.value;
	}

};

// setting up a test binary tree to mess around with
var bst = new BinarySearchTree(50);
bst.insert(30);
bst.insert(70);
bst.insert(100);
bst.insert(60);
bst.insert(59);
bst.insert(20);
bst.insert(45);
bst.insert(35);
bst.insert(85);
bst.insert(105);
bst.insert(10);

console.log('Depth First Traversal (Post-Order)');
console.log('----------------------------------');
bst.depthFirstTraversal(console.log, 3);
console.log('');

console.log('Breadth First Traversal');
console.log('-----------------------------------');
bst.breadthFirstTraversal(console.log);
console.log('');

console.log('Extrema')
console.log('-----------------------------------');
console.log('\tMaximum:', bst.max());
console.log('\tMinimum:', bst.min());



















