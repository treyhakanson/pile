// Factory Design Pattern
// pretty basic, just abstracting functionality
// away from core to make things more modular

var someObject = function() {
	this.value = 'some value';
}

var anotherObject = function() {
	this.item = 'another value';
}

var Factory = function() {
	this.create = function(param) {
		if (param === 'some case')
			return new someObject();
		else
			return new anotherObject();
	}
}

// can create the factory inside
// something like an object,
// singleton, class, etc. to help
// break things down into more
// manageable pieces (Factories
// will likely be private when
// implemented within other objects)
var fac = new Factory();
fac.create('some param');