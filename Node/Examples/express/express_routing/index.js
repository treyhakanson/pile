const express = require('express');
const bodyParser = require('body-parser');

const app = express();
const PORT = process.env.PORT || 8080;

// specify the template engine
app.set('view engine', 'pug');

// this middleware will parse the body of a request containing form data
const urlencodedParser = bodyParser.urlencoded({ extended: false });

// this will parse the body of a json request
const jsonParser = bodyParser.json();

// this request will handle posting json data
app.post('/person-json', jsonParser, function(req, res) {
	res.send('JSON Data Received');
	console.log(req.body.firstname);
	console.log(req.body.lastname);
});

/**
	Express allows for some regex-type expressiongs
	to be specified in routes to allow for more dynamic
	urls (see expressjs.com for more)

	for example, specifying a variable is identical
	to react-router; simply use a color (:), and 
	retrieve from the 'params' property on the 
	request (also identical to react-router)
*/
app.get('/person/:name', function(req, res) { 
	res.send(`<html><head></head><body><h1>Hello ${req.params.name}!</h1></body></html>`);
});

app.get('/person', function(req, res) {
	res.render('index');
});

// urlencodedParser is acting as middleware here, and will run before the proceeding
// function
app.post('/person', urlencodedParser, function(req, res) {
	res.send('Thanks for posting!');
	console.log(req.body.firstname);
	console.log(req.body.lastname);
});

/**
	there are 3 main ways data is passed through
	a request:

	- query string parameters
	- form data
	- json data
*/

// query strings are parsed by express and attached to the request
// (this request will be looking for ?firstName=name&lastName=name)
app.get('/query-strings', function(req, res) {
	res.send(`<html><head></head><body>
		<h1>firstname: ${req.query.firstName}</h1>
		<h1>lastname: ${req.query.lastName}</h1>
	</body></html>`);
});

app.listen(PORT);

















