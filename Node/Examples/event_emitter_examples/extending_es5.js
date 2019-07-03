// extending the event emitter
// ES5
var EventEmitter = require('events');
var util = require('util');

function Greeter() {
	// without this line, Greeter would inherit incompletely
	// from EventEmitter; it would not get the methods that
	// are created when an instance of the Object is created;
	// aka the methods (like greeting below) that are bound to
	// each individual instance rather than the prototype would
	// be lost without this line:
	EventEmitter.call(this); // this works because since 'this' is
	// an object, it is passed by reference to the Constructor of the
	// EventEmitter when invoked with call. Thus, the EventEmitter constructor
	// will be binding all its instance methods and properties to the 'this'
	// that we feed in, and since it is passed by reference these
	// changes will be available to new instances of Greeter since they are
	// created from the same 'this' reference. This is the equivalent of
	// calling 'super' in other languages

	this.greeting = 'Hello World!';
}

// this puts all the PROTOTYPE methods from
// EventEmitter onto the PROTOTYPE of Greeter
util.inherits(Greeter, EventEmitter);

Greeter.prototype.greet = function() {
	console.log(this.greeting);
	this.emit('greet'); // emit can also be used to pass data around, just add args
}

var greeter1 = new Greeter();
greeter1.on('greet', function() {
	console.log('Someone Greeted!');
})

greeter1.greet();