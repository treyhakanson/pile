// MUST USE STRICT IN ORDER TO GET ACCESS TO
// ES6 FEATURES SUCH AS CLASSES
'use strict';

// extending the event emitter
// ES6
var EventEmitter = require('events');
var util = require('util');

class Greeter extends EventEmitter {
	constructor() {
		// gets the instance methods/propertoes
		// from EventEmitter and binds them to the 
		// 'this' object of Greeter Instances
		super();
		this.greeting = 'Hello World!';
	}

	greet() {
		console.log(this.greeting);
		this.emit('greet');
	}
}

const greeter2 = new Greeter();
greeter2.on('greet', function() {
	console.log('Someone Greeted!');
})

greeter2.greet();