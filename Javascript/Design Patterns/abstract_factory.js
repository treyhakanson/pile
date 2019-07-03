// Abstract Factory Design Pattern
// used when needing to implementing 
// a factory that is more dynamic because
// the abstract factory doesn't need to
// know what it is generating

// Essentially, the abstract class will abstract the
// knowledge of what is being generated out of the factory.
// This is done by registering classes (functional 
// constructors, objects, etc.) to the factory to be
//  generated. Very useful when needing to use a structure
// for multiple different scenarios and don't want to
// provide too much distinct functionality that may lead to 
// lack ofportability. Since there are no interfaces in 
// Javascript to check whether the objects being passed
// in as templates for the factory to create from are
// valid (have all the necessary parameters), must do
// some of the legwork manually

// using prototypes is done in order to
// perform an interface type check when
// registering the object for use in
// the factory. This way, can check if the
// object attempting to be registered has
// a particular property/method, which in
// this case is 'create'
function someObject() {  }
someObject.prototype.create = function() {
	this.item = 'some value';
	return this;
};

function anotherObject() {  }
anotherObject.prototype.create = function() {
	this.item = 'another value';
	return this;
};

var Factory = function() {
	// using this object structure to
	// keep track of types so that only
	// one factory is needed for multiple
	// types. Could do this differently
	// if didn't care about creating multiple
	// factories
	var types = {};

	this.create = function(type) {
		return new this.types[type]().create();
	};

	// this is where the objects to be created
	// by the factory are registered, and checked
	// to ensure that the necessary properties are
	// available, acting like an interface. Could
	// do some error handling in the case of an invalid
	// object being passed in (lacking properties), but
	// would rather it just throw the error to signify
	// to the user that something was done incorrectly
	this.register = function(type, object) {
		if (object.prototype.create) 
			this.types[type] = object;
	}

};

// initialize the factory
var fac = new Factory();

// register the desired objects
fac.register('some', someObject);
fac.register('another', anotherObject);

// create as many objects as desired
fac.create('some');
fac.create('another');












