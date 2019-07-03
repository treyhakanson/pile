var http = require('http');

/**
	takes a callback the runs when a request occurs
	req -> the request being made
	res -> the response from the server

	the 'createServer' method has a 'listen' method
	that allows for the specification of which ports
	should be listened to; meaning that the requests 
	made to these ports will be sent to the program
*/
http.createServer(function(req, res) {
	/**
		setting the headers, which are constructed of
		a response code (first argument) and a list
		of key value pairs
	*/
	res.writeHead(200, {
		'Content-Type': 'text/plain', // the type of content the request will be sending
	});

	/**
		the 'end' method just signifies that this is the
		last piece of data to be sent; good to end responses
		with a newline character or carriage return
	*/
	res.end('Hello World\n');
}).listen(8080, '127.0.0.1'); // port, address