// function constructor for the nodes of the
// linked list
function Node(value, next, prev) {
	this.value = value;
	this.next = next;
	this.prev = prev;
}

// Function constructor for the linked list
function LinkedList() {
	this.head = null;
	this.tail = null;
}

// adding functionality to the linked list via
// its prototype
LinkedList.prototype = {
	addToHead: function(value) {
		/**
			no previous node for head, so null
			NOTE: even if the linked list is empty,
			and thus has no head, can still use 'this.head'
			as the argument for 'next' because it will
			be correct regardless (will be 'null' if
			list is empty, will have a value if the list
			is not)
		*/
		var newNode = new Node(value, this.head, null);
		if (this.head) this.head.prev = newNode;
		else this.tail = newNode;
		this.head = newNode;
	},

	addToTail: function(value) {
		var newNode = new Node(value, null, this.tail);
		if (this.tail) this.tail.next = newNode;
		else this.head = newNode;
		this.tail = newNode;
	},

	removeHead: function() {
		if (!this.head) return null; // if the list is empty, do nothing
		var value = this.head.value; // get the current head value
		this.head = this.head.next; // set the head to the next node
		if (this.head) this.head.prev = null; // if there is a head now, meaning that the last element was not removed, remove the prev reference on the new head
		else this.tail = null; // if there isn't a head, the list is now empty, and thus removing the head should also remove the tail
		return val; // return the value of the head that was just removed
	},

	removeTail: function() {
		if (!this.tail) return null;
		var val = this.tail.value;
		this.tail = this.tail.prev;
		if (this.tail) this.tail.next = null;
		else this.head = null;
		return val;
	},

	search: function(searchValue) {
		var currentNode = this.head;
		while (currentNode) {
			if (currentNode.value === searchValue) return currentNode;
			else currentNode = currentNode.next;
		}
		return null;
	},

	indexOf: function(searchValue) {
		var currentNode = this.head;
		var counter = 0;
		var indeces = [];
		while (currentNode) {
			if (currentNode.value === searchValue) indeces.push(counter);
			currentNode = currentNode.next;
			counter++;
		}
		return indeces;
	}
};












