const express = require('express');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 8080;


/**
	static files and middleware
	---------------------------

	middleware: code or software that sits
	between to layers of software and does
	some processing as data comes accross
	(in express, middleware sits between
	the request and the response)

	static files: not dynamic; files that
	are not processed by code in any way
	(css, images, etc.)

	app.use is for specifying middleware
	for the express application
*/

/**
	if there's a request for something at with the path of '/assets',
	use the middleware specified by the second argument. This particular
	line will treat __dirname/public on the server as a directory of
	static content, and it's files will be served from an 'assets'
	route
*/
app.use('/assets', express.static(path.join(__dirname, 'public')));

/**
	all middleware is is a function, so it's very easy to write your
	own:
*/
app.use(function(req, res, next) { // excluding the route in app.use will apply the middleware to every route
	console.log('custom middleware!');
	/**
		calling 'next' just means run the next middleware 
		(basically means this middleware's job is done)
	*/
	next();
});

app.get('/', function(req, res) { 
	/**
		the 'link' tag here calls for a file in '/assets', which will
		utilize the static middleware as speicified in the app.use line
		above
	*/
	res.send(`
		<html>
			<head>
				<link rel="stylesheet" href="assets/styles.css" type="text/css" />
			</head>
			<body>
				<h1>Hello World!</h1>
			</body>
		</html>`
	);
});

app.listen(PORT);

















