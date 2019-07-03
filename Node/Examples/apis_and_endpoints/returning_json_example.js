var http = require('http');
var fs = require('fs');

http.createServer(function(req, res) {
	
	res.writeHead(200, { 'Content-Type': 'application/json' });

	var json = {
		name: {
			first: 'Trey',
			last: 'Hakanson'
		}
	};

	res.end(JSON.stringify(json));

}).listen(8080, '127.0.0.1');