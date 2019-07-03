// the module design pattern allows for obfuscation of code
// so that access of methods (private vs public) can be
// controlled
var module = (function() {
	var privateVariable;
	function privateFunction() {  }

	return {
		publicFunction: function() {  }
	}
}());

module.publicFunction() // ok
module.privateFunction() // error: undefined

// problems with this method:
// private functions or variables
// cannot access public methods