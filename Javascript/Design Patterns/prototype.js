// protoypes are very memory efficient since
// not all instances of a class will create
// their own instances of internal methods

// can use this trick to mimic inheritance
function Shape() {  }
Shape.prototype.size = function(height, width) {
	// some code
};
Shape.prototype.color = function(color) {
	// some code
};

// this method will mimic inheritance by adding all
// the prototypes of one object to another
function clone(childCls, superCls) {
	for (var prop in superCls.prototype)
		childCls.prototype[prop] = superCls.prototype[prop];
}

function Rectangle() {
	this.rect = document.createElement('div');
	this.rect.className = 'rect';
}
clone(Rectangle, Shape); // 'Rectangle' now has both 'size' and 'color'
// on its prototype via the 'Shape' class