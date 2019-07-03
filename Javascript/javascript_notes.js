//////////////////////
// JAVASCRIPT NOTES //
//////////////////////

// General Concepts
	// Hoisting
		// An interesting phenomena occurs in js with variables and function; if a variable/function 
		// is initialized anywhere in the program, it can be called even before the declaration without 
		// throwing an error. For example:

		console.log(a); // a is called before it is declared
		var a = "Hello World";
		// --> prints undefined

		// But this does throw an error:
		console.log(a); // a is not declared at all
		// --> Error

		// This occurs because the js global execution environment that runs on running a program works in
		// two phases. The first is reserving space in memory for all functions and variables before executing
		// the code line by line. Assignments do not occur in the first step, which is why a can be called
		// before its value is assigned, but without a value. Functions are saved to memory in their entirety
		// thoigh, which is why they can be called successfully before assignment.

		// this phenomena is called 'Hoisting' because it's effectively like your vairable and function declarations
		// have been physically moved to the top of the script.

		// 'undefined' is a placeholder for a variable that has not yet been declared

	// Scope Chain
		// Scope chain determines the value of a variable based on the execution stack; a function will always
		// search for the variable in the following order:
			// 1) it's own execution environment
			// 2) the execution environment it was created in
			// 3) down the execution stack

		function a() {
			console.log(myVar);
		}

		function b() {
			var myVar = 2;
			a();
		}

		var myVar = 1;
		b();
		// --> prints 1, because function a was created in the global execution environment, which
		// has a value of 1 for myVar

		function b() {

			function a() {
				console.log(myVar);
			}

			var myVar = 2;

		}

		var myVar = 1;
		b();
		// --> prints 1, because function a was created in b's execution environment, which has a value
		// of 2. if b had no value for myVar, a would go one up the execution train and find a value of
		// 1 for myVar

		// see scrope_chain_scratch_pad.js for more indepth examples

	// Variable Scope
		// for loops and if statements do not get their own execution context. Thus, if a variable
		// is created in an if statement or for loop it will be available from the global context.
		// using let instead of var will make the variable blocking, and only available within the
		// context it was created in (even for forloops and if statements)

	// Event Queue
		// Events are not handled in a truly asynchronous manner; events will be collected by the browser
		// asynchronously, but the will not run until the main execution stack is clear. Once
		// it is clear, it will periodically check the event queue to see if anything needs to be done.
			// This will lead to UI freezes.

	// Primitive Types
		// undefined -> the engine has set no value for the variable (don't set a variable equal to this)
		// null -> there is no value for the variable (you can set a variable to this)
		// boolean -> true, false
		// number -> a floating point number; you can fake other types like integer, but there's
		// 	         really only one number class in js
		// string -> sequence of characters
		// symbol -> not fully supported by browsers yet, new as of ES6

	// Coercion
		// when a type is converted to another; the javascript engine does this often when given two
		// different types and an operand. For example:

		console.log(1 + '2');
		// --> prints 12, because the 1 is coerced into a string and then concated

		console.log(3 < 2 < 1);
		// --> prints true. This is occurs because: 
			// 1.) the associativity of < is left-to-right
			// 2.) 3 < 2 evaluates to false
			// 3.) false is coerced into an integer by the js engine, giving 0 (true is 1)
			// 4.) 0 < 1, true

		// NaN occurs when something that cannot be coerced to a Number type (such as undefined)
		// is attempted to be coerced by the js engine

		// Although coercion is very powerful, it can lead to very weird behavior, particularly when
		// using comparators. For example, even though Number(null) -> 0, the js engine will not
		// always coerce it:

		null == 0 	// --> false
		null < 1 	// --> true

		// the strict equality operator (===) helps a lot with this issue, as it will prevent the js
		// engine from coercing either side
			// also a strict inequality operator (!==)

		// Can check for existense using simply:
		if (myVar) {  }
		// howver, must be mindful that 0 coerces to false in addition to typical variables showing
		// lack of existence:
		Boolean(null)			// --> false
		Boolean(undefined)		// --> false
		Boolean(NaN)			// --> false
		Boolean(0)				// --> false

		// defualt values can be set using the or operand (||) and coercing behavior. This operand
		// when used will take the value that CAN be coerced to true rather than actually just returning
		// true or false
			// this is great for functions, since all params in js are optional

		function greet(name) {
			name = name || "Anonymous"
			console.log("Hello " + name + "!");
		}

		greet("Trey");	// prints "Hello Trey!"
		greet();		// prints "Hello Anonymous!"

		// if both args are true, the first will be returned
		"Hello" || "World" // evaluates to "Hello"

	// Objects and Functions
		// object properties and or functions can be accessed using either the dot operator or
		// computed member access. The dot operator essentially passes the property after it
		// as a string to the computed access member function

		object.property;
		object["property"];

		// Computed member access is useful because with it functions and
		// or properties can be accessed dynamically

		var propertyToAccess = "property";
		object[propertyToAccess];

		// anonymous functions have no name, and may be stored in a variable
		var anonymousFunction = function() {
			// do stuff
		}

		// javascript allows for first class functions, which can be created on the fly, stored in
		// variables, passed around, etc.

		// no function overloading in js (having multiple functions of the same name with different argument structures)
		// since all functions are first-class functions and stored as objects, but this doesn't matter because
		// you can optionally drop parameters so this can all efectively be done with one function call and some
		// additional logic to handle different scenarios within the function

		// can immediately invoke a function on creation using IIFE (Immediately Invoked Function Expression) syntax
		var iifeExample = function(arg) {
			return arg;
		}("Hello World"); // will immediattely execute and store "Hello World" in iifeExample

		// can also create IIFE's that don't return to a variable by adding parenthesis to trick the
		// syntax parser into viewing the function as a function expression (will be viewed as a 
		// syntax error if no parenthesese are used)

		(function(name) {
			console.log("Hello " + name);
		}("Trey")); // will execute immediately and not throw any errors
		// could move the innvocation (the ("Trey") part) outside of the parentheses if desired

	// JSON
		// JavaScript Object Notation
		// JSON can be converted straight into a js object and vice versa

		JSON.parse(rawJSON);
		JSON.stringify(jsObject);

		
	// Passing Data
		// primitives are based by value, objects by reference
		

	// 'this' keyword
		// refers to an execution context
		// has some interesting behavior depending on what context it is called in

		// if called within a normal function declaration, 'this' refers to the global object.
		// This leads to some interesting behaviors; like creating global variables from
		// within a function:

		function a() {
			this.newVariable = "Hello World";
		}

		a();
		console.log(newVariable)
		// newVariable has been added to global context, will print "Hello World"

		// calling this within an object method (a function within an object) refers to the wrapping object
		var obj = {
			name: 'Object 1',
			method: function() {
				console.log(this.name);
			}
		}

		obj.method();
		// prints "Object 1"

		// keep in mind that for a function created within an object method, 'this' points
		// to the global object (pretty strange)

		var obj = {
			method: function() {
				var func = function() {
					console.log(this); // this prints the window object, not obj
				}
			}
		}

		// a common practice is to create a variable 'self' within object method and use it in place of 'this'
		// to prevent strange behavior
		var obj = {
			method: function() {
				var self = this;
				var func = function() {
					console.log(self); // this now prints obj, which is likely the desired behavior
				}
			}
		}

	// Arrays
		// don't have to be homogeneous in type
		// can have objects and functions too
		
		// 'arguments' is a variable created by a function, containing all the parameters in an psuedo-array;
		// psuedo because it doesn't have all the feature of a js array
		// arguments will become deprecated soon
			// will soon get rest (spread) paramters instead, which are like variadic parameters in swift, and
			// must be the final arg in a function call

			function spreadFunc(arg1, arg2, ...args) {
				console.log(arg1);
				console.log(arg2)
				console.log(args)
			}

			spreadFunc("Hello", "World", "extra1", "extra2");
			// extra1 and extra2 will be printed in args

	// Closures
		// closures maintain references to variables in outer lexical envirnoment even after they're popped from
		// the execution stack

		function greet(greeting) {
			return function(name) {
				console.log(greeting + " " + name + "!");
			}
		}

		var sayHello = greeting("Hello");
		sayHello("Trey"); // prints "Hello Trey!"; even though the execution context of 'greet' is popped from the
		// stack after it returns, the anonymous function that it returns maintains a reference to the memory
		// location of the variable 'greeting' because it has not been garbage collected
		// referred to as an execution context "closing in" all the variables it's supposed to have access too; a
		// "closure" is created

		// classic closure example
		function buildFunctions() {
			var arr = [];
			
			for (var i = 0; i < 3; i++) {
				arr.push(function() {
					console.log(i);
				});
			}

			return arr;
		}

		var fs = buildFunctions();

		fs[0](); // prints 3
		fs[1](); // prints 3
		fs[2](); // prints 3
		// all calls print 3 because they simply store a reference to the location of i in memory;
		// since they are invoked when the for loop has completed, i will be 3
		
		// could get around this using let in ES6, which is only scoped for the block, not the entire context

		// in ES5, have to get a little wacky and use an IIFE around the function creation to create an appropriate
		// execution context containing the correct value of the variable:

		function buildFunctions2() {
			var arr = [];

			for (var i=0; i < 3; i++) {
				arr.push(
					(function(j) {
						return function() {
							console.log(j);
						}
					}(i))
				);
			}

			return arr;
		}

		fs2 = buildFunctions2();

		fs2[0](); // prints 0
		fs2[1](); // prints 1
		fs2[2](); // prints 2

	// call(), bind(), apply()
		// all functions get these methods by default

		// bind takes in an argument to act as this, and then returns a copy of the function with the proper changes
		var obj = {
			name: "obj name",
			version: "v1.0",
			getDetails: function() {
				return name + ": " + version;
			}
		}
		
		var logObjDetails = function() {
			console.log(this.getDetails());
		} // would fail if called straigh up because the global object does not have an innvocable
		// method 'getDetails'

		var logName = logObjDetails.bind(obj); // this method will call successfully with obj as this,
		// and will print "obj name: v1.0". Keep in mind that this will create a copy of the 'logObjDetails' 
		// function, but will set 'this' to the argument of 'bind' on creation of the execution context

		// could have also put 'bind(obj)' straight after the 'logObjDetails' declaration and then invoked it
		// for the same effect
		var logObjDetails = function() {
			console.log(this.getDetails());
		}.bind(obj);
		logObjDetails(obj); // will print "obj name: v1.0"

		// 'call' is similar to bind, but can be thought of more like an IIFE in that it doesn't create a copy,
		// it just executes with the given this/params

		function helloWorld(first, last) {
			console.log("Hello World! I am " + first + " " + last + " from " + this);
		}

		helloWorld.call("Cincinatti", "Trey", "Hakanson"); // 'this' is always first args 
		// (will log "Hello World! I am Trey Hakanson from Cincinatti")

		// can also use 'call' in a truly IIFE way:
		(function helloWorld(first, last) {
			console.log("Hello World! I am " + first + " " + last + " from " + this);
		}).call("Louisville", "Trey", "Hakanson");
		// (will log "Hello World! I am Trey Hakanson from Louisville")

		// only difference bewteen 'call' and 'apply' is that 'apply' takes args as a list
		(function helloWorld(first, last) {
			console.log("Hello World! I am " + first + " " + last + " from " + this);
		}).call("Louisville", ["Trey", "Hakanson"]);
		// (will log "Hello World! I am Trey Hakanson from Louisville")		

	// function borrowing
		var person = {
			firstname: 'Trey',
			lastname: 'Hakanson',
			getFullName: function() {
				return this.firstname + ' ' + this.lastname;
			}
		}

		var otherPerson = {
			firstname: 'Eileen',
			lastname: 'Guan'
		}

		person.getFullName.apply(otherPerson);
		// this will call the 'getFullName' function of 'person', but with 
		// 'otherPerson' as the this keyword (will return 'Eileen Guan');

	// function currying
		// definition: creating a copy of a function, but with some preset
		// parameters (usually using 'bind')

		// very useful in mathematical programs, because a basic template function
		// can be copied to create many custome functions built on the same
		// backbone

		// params passed to 'bind' after the 'this' argument will permananetly
		// set the function args
		function multiply(a, b) {
			return a * b;
		}

		var multiplyByTwo = multiply.bind(this, 2);
		// we aren't using 'this' in the function body so we don't need to set it to
		// anything new and thus just pass the global; the 2 will permanently set the 
		// value of 'a', effectively creating the following function: 
		function multiplyByTwo(b) {
			var a = 2;
			return a * b;
		}

	// functional programming
		function mapForEach(arr, fn) {
			var newArr = [];
			for (var i = 0; i < arr.length; i += 1) {
				newArr.push(
					fn(arr[i])
				);
			}
			return newArr;
		}	

		var arr = [1, 2, 3];
		var doubledArr = mapForEach(arr, function(item) {
			return item * 2;
		}); // returns [2, 4, 6]

		isGreaterThan2Arr = mapForEach(arr, function(item) {
			return item > 2;
		}); // returns [false, false, true]

		var multiplyBy = function(a, item) {
			return a * item;
		}

		var tripledArr = mapForEach(arr, multiplyBy.bind(this, 3)); // returns [3, 6, 9]

		var multiplyByImproved = function(a) {
			return function(item) {
				return a * item;
			}
		}

		var trippledArrImproved = mapForEach(arr, multiplyByImproved(3));

	// prototypal inheritance
		// all js objects have access to another object called "prototype" by default
		// when an objects property is called, it first checks the instance for the property.
		// If it can't be found, it looks to the prototype. If it can't be found there,
		// it keeps going back prototypes until there aren't any left. All these prototypes
		// are a part of what's called the "prototype chain" of an object

		// Say we have a prop3 property attached to the second prototype of an object; instead
		// of calling object.prototype.prototype.prop3, you can just call object.prop3 and let
		// the javascript engine locate the property for you

		// objects can share prototypes

		// everything has a protoype in javascript

		// 'Object' is always the base of the prototype chain regardless of type (function,
		// object, array, etc.)

		// reflection: an object can look at itself, listing and changing its properties 
		// and methods

		// can use a for in loop to iterate over all the properties of an object or collection
		for (var prop in obj) { // 'prop' will be the NAME of the property (obj[prop] will give the value)
			// do stuff
		} // will grab methods and prototype properties/methods too
		
		// can check 'hasOwnProperty' to mitigate this; will return true if the object has the
		// property or method, not just the prototype (so something like 'toString' would 
		// return false, because it's a prototype method)
		// will also return false if property is nowhere in the prototype chain
		for (var prop in obj) {
			if (obj.hasOwnProperty(prop)) {
				// do stuff
			}
		}

	// function constructors
		// these are functions used solely for the purpose of constructing objects

		// the 'new' keyword when used with a function constructor will create an object
		// as the 'this' keyward, which will then be the return value of the function
		// unless there is another return statement in the way
		function ExampleObject() {
			this.prop1 = "Hello";
			this.prop2 = "World";

			this.method1 = function() {
				// do things
			}

		}

		var exampleObj = new ExampleObject();
		// will have properties prop1 and prop2, and a method of method1

		// the prototype property is used for function constructors; anything set using 'proptype'
		// will be attached to the prototype of objects created using the function construct.
		// prototype IS NOT the prototype of the function (that's __proto__)!
		// Essentially, using the 'new' keyword with a function constructor does this:
		instance.__proto__ = Constructor.prototype

		// the prototype can be changed on the fly, and will affect objects created even before the
		// prototype was changed

		// adding methods via the prototype is best practice because if it is added in the body of
		// the constructor, every new object created will get it's own method stored into memory.
		// this isn't necessary, so giving one method to the prototype and allowing all the objects to
		// call it is best
		// Example:

		// -------- NOT GOOD ---------

		function Person(first, last) {
			this.first = first;
			this.last = last;

			this.getFullName = function() {
				return this.first + ' ' + this.last;
			}

		}

		var jane = new Person('Jane', 'Doe');
		var john = new Person('John', 'Doe');
		var jim = new Person('Jim', 'Bob'); // this stores 3 'getFullName' methods into memory

		// -------- BETTER ---------

		function Person(first, last) {
			this.first = first;
			this.last = last;
		}

		Person.prototype.getFullName = function() {
			return this.first + ' ' + this.last;
		}

		var jane = new Person('Jane', 'Doe');
		var john = new Person('John', 'Doe');
		var jim = new Person('Jim', 'Bob'); // now all the 'Person' instances share 1 'getFullName' method

		// NEVER use for in loops for arrays in javascript, because arrays are just objects whose values are 
		// added as properties, so if a you or a third party library adds something to the 'Array' prototype, 
		// it will also be iterated over in a for in, since for in loops iterate over properties. Elements in 
		// an array (like 1 in [1, 2, 3]) are simply added as properties of a new array obejct upon using the 
		// square bracket [] literal syntax

		// another way to create object is using Object.create (implemented in most browsers)
		// this will create an object whose prototype has all the properties and methods of the
		// argument object. Keep in mind this is not available in older browsers
		var testObject = {
			prop1: 'Default',
			prop2: 'Default',
			method1: function() {
				// do something
			}
		}

		var anotherObject = Object.create(testObject);
		// anotherObject is a blank object whose protoype is prop1, prop2, and method1

		// polyfill: code that adds a feature the engine may lack
		// here's an example of polyfilling Object.create:
		if (!Object.create) { // check if the method exists, run this if not
			Object.create = function(o) {
				if (arguments.lenght > 1) throw new Error('Object.create\
					implementation on takes the first parameter.');
				function F() {}
				F.prototype = o;
				return new F();
			}
		}

	// Javascript 'Classes' (ES6)
		class Example {
			constructor(prop1, prop2) {
				this.prop1 = prop1;
				this.prop2 = prop2;
			}

			function method1() {
				// do something
			}

		}

		var example = new Example("Property 1", "Property 2");

		// unlike other languages where classes are basically templates for creating objects,
		// a javascript class definition is itself an Object

		// this is almost hacky in terms of Javascript, Object.create is the best way to use
		// true prototypal inheritance

		// extends will also be added in ES6

		// syntatic sugar: changes the way you type something, but doesn't change the way
		// it works under the hood


	// figuring out what something is
		// typeof returns the type of a variable/value
		typeof 4 // return number (lowercase)

		// determining the type on of an array
		var arr = [];
		typeof arr // returns object, because arrays are objects
		Object.prototype.toString.call(arr) // returns [object Array]; using call because we want
		// to call the object prototype's toString method on something other than Object. Calling
		// toString on arr straight up doesn't work because the Array object has its own implementation
		// of toString above the Object.prototype level

		// isntanceof will return true if anywhere down an objects prototype chain, it find the given object type
		function TestObject(name) {
			this.name = name;
		}

		var testObj = new TestObject('example');
		testObj isntanceof TestObject // will return true, because testObj is an instance of TestObject

		// keep in mind the following!
		typeof null // returns 'object' (known bug)

		// you can see if something is typeof function (won't just return object)

	// strict mode
		// strict mode will tell the javascript engine to be stricter, eliminating certain errors
		// for example, typos:

		// normal, unstrict js engine
		var person;
		persom = {}; // misspelled person, won't through an error

		// strict js engine
		"use strict"; // tells the engine to be strict
		var person;
		persom = {}; // person was misspelled, error is thrown

		// "use string" can be used on a per execution context basis, so you can drop it in functions rather
		// than the global context if desired

	// Method Chaining
		// calling one method after another, with each method affecting the parent object
		// ex:
			obj.method1().method2(); // method1 and method2 affect obj
		
	// Transpile
		// convert the syntax of one language into anthor; never run anywhere, only transpiled into
		// a language that is run
		








