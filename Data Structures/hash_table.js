// some notes on charCodeAt (needed for the hashing function,
// only with the modulus operator %)

// charCodeAt is a method on the string prototype that
// takes an index of a string and converts that character
// into a unique integer. Here, the character at the 4th
// index of the string 'hello world' is converted.
'hello world'.charCodeAt(4); // o -> 111

// hash table constructor function
function HashTable(size) {
	this.buckets = Array(size); // initiate the size of the hash table
	this.numBuckets = this.buckets.length;
}

// function constructor for hash table buckets (hash nodes)
function HashNode(key, value, next) {
	this.key = key;
	this.value = value;
	this.next = next || null; // refers to the next hash node in the bucket if there are any collisions
}

HashTable.prototype = {
	// hashing function
	hash: function(key) {
		var total = 0;
		for (var i = 0; i < key.length; i++) total += key.charCodeAt(i);

		// the mod operator will make sure that the hash value
		// is not out of index for the bucket array
		return total % this.numBuckets; // bucket index
	},

	insert: function(key, value) {
		var hash = this.hash(key);
		if (this.buckets[hash]) {
			var currNode = this.buckets[hash];
			if (currNode.key === key) { // checking if attempting to update an exsiting key
				currNode.value = value;
				return;
			}
			while (currNode.next) {
				currNode = currNode.next;
				if (currNode.key === key) { // checking if attempting to update an exsiting key
					currNode.value = value;
					return;
				}
			}
			currNode.next = new HashNode(key, value);
		} else  this.buckets[hash] = new HashNode(key, value);
	},

	get: function(key) {
		var hash = this.hash(key);
		var node = this.buckets[hash];

		while (node) {
			if (node.key === key) return node.value;
			else node = node.next;
		}

		return null;
	},

	getAll: function() {
		var arr = [];
		for (var i = 0; i < this.numBuckets; i++) {
			var node = this.buckets[i];
			while (node) {
				arr.push(node.value);
				node = node.next;
			}
		}
		return arr;
	}

};

var ht = new HashTable(30);

ht.insert('Trey Hakanson', 'trey@hatchli.io');
ht.insert('Grant Hakanson', 'granthakanson@gmail.com');
ht.insert('Mom', 'hakclan@bellsouth.net');
ht.insert('Mckenna Hakanson', 'kennahak@gmail.com');

// these will collide
ht.insert('Dean', 'dean@gmail.com');
ht.insert('Dane', 'dane@gmail.com');

var tEmail = ht.get('Trey Hakanson');
var dEmail = ht.get('Dane');

var allEmails = ht.getAll();

console.log('Trey Hakanson\'s Email:', tEmail);
console.log('Dane\'s Email:', dEmail);
console.log('All Emails:', allEmails);

















