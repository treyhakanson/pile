// NOTE: I'm using jsc for this, so debug is used to print not console.log

function a() {

	function b() {

		function c() {
			var myVar = 'c';
			debug(myVar);
		}

		var myVar = 'b';
		debug(myVar);
		c();

	}

	var myVar = 'a';
	debug(myVar);
	b();

}

var myVar = 'global'
a();

// function a() {

// 	function _1() {
// 		debug("a.1");

// 	}

// }

// function _1() {
// 	debug("global.1");
// }

// a();