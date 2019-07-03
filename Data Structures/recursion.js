// example of what recursion looks like at its most basic
function func() {
	if (/* base case */) {
		return something;
	} else func(); // recursive case
}

// factorial function using recursion
function factorial(num) {
	if (num < 1 || Math.floor(num !== num)) 
		throw new Error('factorial input must be a positive integer, instead got: ' + num);

	/**
		this structure is useful for recursive functions
		because it is very clean and simply; have a base
		case that returns the value passed in, and have a
		recursive case that calls the function again
	*/

	// factorial techincally includes 1, but because multiplying by 1 
	// does nothing it's more performant to break beforehand
	if (num <= 2) { // base case
		return num;
	} else { // recursive case
		return num * factorial(num - 1);
	}
}
