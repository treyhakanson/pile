function spreadDemo(...args, finalArg) {
	console.log(args);
} // will throw an error because the rest parameter (...args) must be final parameter in function definition

spreadDemo("Hello", "World", "I'm", "Trey");

// new method of setting defaults
function testFunc1(arg1 = 'def1', arg2 = 'def2', arg3 = 'def3') {
	// good to go
}

// old method of setting defaults
function testFunc2(arg1, arg2, arg3) {
	arg1 = arg1 || 'def1';
	arg2 = arg2 || 'def2';
	arg3 = arg3 || 'def3';
	// good to go
}