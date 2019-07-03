// decorators add features to a specific objects
// without creating a subclass or changing the
// original interface/ constructor

// pretty simple stuff
var someObj = {/* some stuff */};

function decorator(obj) {
	someObj.addedMethod = function() {
		// do some cool stuff
	}
}

decorator(someObj);
someObj.addedMethod(); // this is now callable
