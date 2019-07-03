var fs = require('fs');
var path = require('path');

/**
	quick note on path:
	==================================================
	the difference between join and resolve is that
	'join' will simply concat strings, whereas resolve
	will act as if actually navigating to those 
	directories:

	path.join('/a', '/b') 		-> Outputs '/a/b'
	path.resolve('/a', '/b') 	-> Outputs '/b' (think of it running cd /a && cd /b)
*/

/**
	readFileSync, when called, loads the binary of
	the file into a buffer, applies the appropriate 
	encoding, and then outputs the contents as a 
	string. Also, this is synchronous (blocking)
*/
var text = fs.readFileSync(path.join(__dirname, 'file.txt'), 'utf8'); // default encoding for readFileSync is utf8, specifying anyway
console.log(text); // outputs 'hello world!' (see file.txt)

/**
	readFile should be used more often because it is
	asynchronous, and just asks for a callback. Pretty
	much only use readFileSync for something like a config
	file that is absolutely necessary before anything else
	can be done. Otherwise, the application will slow down
	tremendously when multiple users call to load the same
	file. Also, unlike readFileSync, readFile requires an
	encoding parameter or it will output a buffer
*/
// NOTE: nearly all async functions in node take 'Error-First Callbacks',
// or callbacks whose first parameter are errors
var text = fs.readFile(path.join(__dirname, 'file.txt'), 'utf8', function(err, data) {
	console.log(data); // still outputs 'hello world!' (see file.txt)
});