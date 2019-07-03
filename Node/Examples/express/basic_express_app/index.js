const express = require('express');
const app = express();

/**
	Environment Variables: global variables
	specific to the environment (server) code
	is living in. Different servers can have
	different variable settings, which can
	be very useful to access
*/

/**
	check if the process is giving us and
	environment variable specifying which
	port we should use. If not, just go
	ahead and default to some other port
	(8080 in this case)
*/

const PORT = process.env.PORT || 8080;

/**
	HTTP Methods (or Verbs): specifies the
	type of action a request wishes to make
	(GET, POST, DELETE, etc.)
*/
app.get('/', function(req, res) { // if a get request is made to the url '/', do this
	// express doesn't require the content type to be specified; it'll
	// look at the data and determine it's type
	res.send('<html><head></head><body><h1>Hello World!</h1></body></html>'); // inlining as an example
});

app.get('/json', function(req, res) {
	res.json({ name: { first: 'Trey', last: 'Hakanson' } });
});

app.listen(PORT);

















