var http = require('http');
var fs = require('fs');
var path = require('path');

http.createServer(function(req, res) {

	res.writeHead(200, { 'Content-Type': 'text/html' });

	// read in the html and pipe to the response (which is a variant of a transform stream)
	fs.createReadStream(path.join(__dirname, 'index.html')).pipe(res);

}).listen(8080, '127.0.0.1');