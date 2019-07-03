// Singleton Design Pattern
// used to manage a single object that needs to be accessible
// to multiple parts of an application while mainting only
// one signle instance

// setup the signleton
var ExampleSignleton = (function() {
	// setup instance to be returned
	var instance;

	// initialize the singleton
	function _init() {
		// signifying private methods with a leading
		// underscore makes it easy to see what
		// is and isn't exposed on retrieving the
		// singleton instance
		_somePrivateMethod() {
			// some code
		}

		somePublicMethod() {
			// some code
		}

		anotherPublicMethod() {
			// some code
		}

		// expose only the public methods upon
		// calling for the singleton
		return {
			somePublicMethod,
			anotherPublicMethod
		};
	}
	
	// return public methods to be exposed
	// upon calling for the singleton
	return {
		// get instance or instantiate it if
		// not yet created. Cool because this
		// way no memory is allocated until
		// the singleton is needed
		getInstance: function() {
			if (instance)
				return instance;
			else
				instance = _init();
				return instance;
		}
	}

}());