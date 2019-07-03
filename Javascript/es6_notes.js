// arrow functions have a shorter syntax compared to function expressions, always anonymous
	(param1, param2, paramN) => { /* statements */ }

	// these two are the same
	(param1, param2, paramN) => // expression
	(param1, param2, paramN) => { return /* expression */ } 

	// parenthesis are optional when only one param
	param => // expression

	// no parameters
	() => { /* statements */ }

	// parenthesize the body to return an object
	params => ({ obj: "literal" })

	// rest and default parameters are supported
	(param1, param2, ...rest) => { /* statements */ }
	(param1 = defaultValue1, param2, paramN = defaultValueN) => { /* statements */ }

	// deconstruction (?) is allowed
	var f = ([a, b] = [1, 2], {x: c} = {x: a + b}) => a + b + c;
	f();  // 6

	// can create arrow IIFEs
	((x) => 1 + x)(5) // returns 6

// Using Generators to create Iterators
	// are declared with function and *
	function *numbers() { // * can go after function or before function's name (numbers here)
		const result = 1 + 1;
		return 20 + (yield result);
	}

	const gen = numbers(); // instatiating the generator
	gen.next(); // will run until a 'yield' statement is found, yield the corresponding value, and pause execution
	// so, the above yields 'result' before returning, giving: 
	// { value: 2, done: false }
	gen.next(10); // generator is now called with a value, which will replace the yield statement, then causing the
	// funtion to return, since there is no additional yield. This will give:
	// { value: 30, done: true } (done because there are no more yields)
	// if gen.next is called with or without a value again, it will just return { done: true }

	function* list() {
		yield 1;
		yield 2;
		yield 3;
	}
	const lGen = list();
	lGen.next(); // { value: 1, done: false }
	lGen.next(); // { value: 2, done: false }
	lGen.next(); // { value: 3, done: false }
	lGen.next(); // { done: true } (no value because there is no explicit return)
	// if lGen.next is called again, will just keep returning { done: true }

	// can also iterate over a generator with a for of loop
	const numbers = [];
	for (let value of list()) numbers.push(value);
	// numbers = [1, 2, 3]

	// can yield generators to other geerators using yield*
	function *otherList() {
		yield* list();
		yield 4;
		yield 5;
		yield 6;
	}

	const n = [];
	for (let v of otherList()) n.push(v);
	// n = [1, 2, 3, 4, 5, 6]

	// further example
	class Tree {
		constructor(value = null, children = []) {
			this.value = value;
			this.children = children;
		}
	
		*getValues() {
			yield this.value;
			for (let child of this.children) yield* child.getValues();
		}
	}

	const tree = new Tree(1, [
		new Tree(2, [new Tree(4)]),
		new Tree(3)
	]);

	const values = [];
	for (let v of tree.getValues()) values.push(v);
	// v = [1, 2, 4, 3] (goes to maximum depth at each branch it hits before moving on)

// Promises
	// promises can only execute code for success/failure ONCE, preventing
	// the accidental firing of multiple functions as happens with
	// callbacks

	function fetchData() {
		// fetch some data...
		return new Promise((resolve, reject) => {
			// even though both resolve and reject are
			// called here, only the first called (resolve)
			// will run
			resolve(/* some data */); 
			reject(/* some error */);
		});
	}

	fetchData()
		.then(data => {
			// runs if the promise successfully
			// resolves
		})
		.catch(error => {
			// runs if the promise fails to 
			// resolve
		});

	// Debugging
		// can use the keyword "debugger" at any point in code to run the
		// debugger. this allows for variables in that context to be typed
		// into the console, showing their value. For example:

		...
		function someFunction(a, b, c) {
			// do some stuff
			debugger;
		}
		...

		// after 'someFunction' is called, the debugger will pause the program,
		// and any of the variables a, b, c, or anything other variables
		// in this IMMEDIATE context, can be called from the console to see 
		// their values

		// can also use the 'devtool' property if using webpack (see webpack notes)








