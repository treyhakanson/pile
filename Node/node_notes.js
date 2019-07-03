// back quotes (``) are used in place of normal quotes ('' or "") to create a template string,
// which allos for swift-like variable injection into strings
	// *** This also works in js ***

var myVar = 'World'
console.log(`Hello ${myVar}!`)
// --> prints "Hello World!"

console.log('Hello ${myVar}!')
// --> prints "Hello ${myVar}!"

// NPM Scripts
	// common NPM Scripts:

		// in package.json
		"scripts": {
			"start": "node index.js",
			"test": "npm mocha",
			"custom-script": "echo npm"
		}

		// start -> where your program will start (npm start)
		// test -> run your test scripts (npm test)
		// custom-script -> can be anything, with whatever name you choose (npm run custom-script)

// Node is written in C++, and so is the Javascript engine
// V8, which compiles js down to machine code.

// ECMAScript is the standard js is based on (describes how
// javascript should work)

// node is just a C++ program that embeds the V8 js compiler
// and adds features to the javascript language, thus
// creating a framework.

// Modules: reusable blocks of code that don't affect other
// blocks unless explicity called upon to do so.

// commonjs modules: the agreed upon standard of how code
// modules should be structured

// module.exports specifies would should be pulled when importing a module
module.exports = {
	// exports
}

// primitives are passed by value, objects are passed
// by reference (even if passed into a function)
function change(o) {
	o.id = 2;
}

var obj = { id: 1 }
change(obj);
// obj.id is now 2

// apply can be used to pass 'this' AND arguments to a function
someFunc.apply(newThis, [some, arg, uments]);

// call does the exact same thing as apply, execept instead of passing
// an array of parameters your just pass a comma separated list like
// for a normal function invocation:
someFunc.call(newThis, some, arg, uments); // this is the same as the
// above 'apply' innvocation

// some notes on modules and require
// when you create a module and specificy module.exports,
// you're telling the V8 engine what will be return when
// that module is loaded into a separate file. require is
// what tells V8 to load in the module, and the module is
// wrapped in a function expression in order to keep scope
// clean when it is loaded. The function is invoked with
// appy, which attaches a few arguments:
	// - exports
	// - require
	// - module
	// - __filename
	// - __dirname
// this is why all of the above are available at any given time;
// it's because all code gets wrapped by the V8 engine and these
// variables added, such that they can be used from any module.
// module.exports is what actually get returned for the wrapped
// code, which is why in order to expose parts of the module
// to whatever file is importing it, they need to be included
// here or else the will not be usable outside the scope of 
// the wrapper function that is created by the V8 engine.

// more or less this:
(function(exports, require, module, __filename, __dirname) {
	/* some module code... */
	module.exports = someExport;
});

fn(module.exports, require, module, filename, dirname);

return module.exports;

// can require .json files, and upon reading in the javascript
// engine will automatically convert them to javascript objects
// this is good for storing data like text in a module (don't need
// to use module.exports for json files, they will just be loaded
// in as a singular object)

// required modules are cached, so requiring the same module
// multiple times within a file will get the exact same reference
// even if the module is creating a new object on export (this could
// potentially be very useful for shipping out things like singletons
// and such)

// can export a function constructor or class instead of creating and
// object and then exporting it to allow for require to create new objects

// there is one key quirk in Javascript to consider when passing by reference;
// if two objects point to the same place in memory, and one is changes using
// the equal operator (=), the right side of the operator will be stored in
// a new location in memory and the variable will now point to that, thereby
// breaking the reference. In summary, changing/Adding properties will affect 
// all references, but setting a reference using the equal operator will store 
// the new value in a new location in memory and the variable changed will now
// point to that reference.

// (Node API Docummentation)[https://nodejs.org/dist/latest-v6.x/docs/api/j]

// Node Events
// System Events (libuv) -> These are from the C++ Core, and pertain to events like
// when a file has been read in, when a data stream has closed, etc. (These
// events pertain to things that Javascript does not handle by itself)
// Custom Events (Event Emitter) -> These are from the Javascript Core, and deal with events
// that can be created and handled from the Javascript
// System events will often generate Custom Events so that they can be easily handled
// from the Javascript without having to write C++ code and port it over

// Check out event_emitter_example for an example of how the event emitter works

// Magic String -> a string that has some special meaning in our code; this is bad
// because it makes it easy for a typo to cause a bug and hard for tools to help
// us find it

// inherits can be used to add the methods and properties from one object to the
// prototype of another
var parentObject = { prop1: 'hey', prop2: 'hola' }
var objectToAddTo = { prop3: 'hello' }

var newObject = inherits(objectToAddTo, parentObject);
// newObject has 

// MUST BEING USING STRICT JS TO USE ES6 FEATURES

// Node is Async, V8 is not

// Buffer: A temporary holding spot for data being moved from one place
// to another; typically small in size because data shouldn't remain stored
// in the buffer for very long

// Stream: a sequence of data made available over time; aka pieces of data
// that over time will come together to form a whole

// Data flows more or less like this:
// Stream -> Buffer -> Process
// Chunks of data are taken from the string and loaded into the buffer,
// and once the buffer is full it will place that chunk of data into
// the process, which will handle what needs to be done to process that
// chunk of data

// character set: a representation of characters as numbers (since computers
// can only store one's and zeros, we need character sets to keep track of things
// that aren't numbers, such as letters)

// character encoding: how characters are stored in binary. The numbers (or code
// points) from the corresponding character sets are converted and stored in binary

// binary math
// 0    1    1    0    1
// 2^4  2^3  2^2  2^1  2^0
// 16*0 8*1  4*1  2*0  1*1
// 0 +  8 +  4 +  0 +  1
// = 13

// h -> 104 -> 01101000
// chracter -> code point (via chracter set) -> binary (character encoding)

// Buffers
var buffer = new Buffer('Hello', 'utf8'); // default encoding for Buffer is utf8 if not specified
console.log(buffer); // will output in hexadecimal notation: <Buffer 48 65 6c 6c 6f>
console.log(buffer.toString()); // will output as a String: Hello
console.log(buffer.toJSON()); // outputs an object: { type: 'Buffer', data: [ 72, 101, 108, 108, 111 ] } 
										// where each element in the data array is a code point
console.log(buffer[2]); // will output the second code point in the buffer: 101

buffer.write('World'); // will not append Hello, but will overwirte it because buffers are finite
							  // and this particular buffer was initialized to 5 characters (because hello
							  // is 5 characters)

// ArrayBuffers allow V8 to handle binary data (ES6)
var aBuffer = new ArrayBuffer(8) // takes a number that specifies the amount of bytes (1 byte = 8 bits, so this is 64 bit)
var view = new Int32Array(aBuffer); // this will convert the buffer into an array of 32 bit integers, and changing this
												// array will also change the buffer, this just makes it possible to work with. Since
												// this is 32 bits and the array buffer is only 64 bits, we can only store 2 numbers in
												// it

view[0] = 5;
view[1] = 15;
view[2] = 30; // nothing will happen; the buffer can only hold 2 32 bit integers

console.log(view);

// Abstract (Base) Classes: a type of constructor that is never worked directly
// with, only inherited from to build custom, usable object

/**
	QUESTION: Browser requests say in their headers that they
	accept gzip encoding, does that mean that the data in a response
	could be gzipped before sending if it was large to perserve
	bandwidth? I assume yes, but would the browser automatically
	decode it? Or would it be time intensive to do so on the client's
	side?

	ANSWER: I tried this and as expected, it sent gzip encoded information
	to the browser which would in turn need to be decoded client side or
	at least would need to somehow inform the client that it was gzipped
	html content (or other content) in the headers so it could hanle
	things automatically (this may be impossible)
*/

/**
	interesting aside: htm and html files are the same, but old
	versions of windows used to strictly enforce only 3 letter
	file extensions, so the l was dropped when serving files from
	a windows based server
*/


/**
	Semantic Versioning (semver.org):
	version numbers actual do have a protocol:
	major.minor.patch -> 1.7.2

	patch -> bug fixes and performance ehances, no
	breaking changes (existing code built on this
	code will run fine)

	minor -> some new features were added, still no
	breaking changes (existing code built on this
	code will run fine)

	major -> big changes, potentially breaking (existing 
	code built on this code will likely not work anymore)
*/

/**
	you can browse npm packages at npmjs.com
*/

// can run outbound by specifying an extra parameter in .listen:
app.listen(PORT, '0.0.0.0', function() { // 0.0.0.0 will tell the server to run outbound on the device's ip
	/* server has started */
});















