// solves these problems of the module design
// pattern:

// private and public are treated differently
// ensure private members can't interact with public ones
// add complexity to the core structure

var module = (function() {
	// leading underscores on private
	// members to make things easy to
	// understand
	var _privateVariable;
	function _privateFunction() {  }

	// public members
	function publicFunction() {  }

	return {
		// only the methods returned here will
		// be accessible to the outside
		publicFunction: publicFunction
	}
}());

module.publicFunction() // ok
module._privateFunction() // error: undefined

// one problem with any module pattern is that it is 
// final; methods/members cannot be changed once the
// module is instatiated