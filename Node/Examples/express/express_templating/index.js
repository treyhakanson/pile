const express = require('express');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 8080;

app.use('/assets', express.static(path.join(__dirname, 'public')));

/**
	this tells express what type of file extensions will
	be used as templates (by default, app.set will look
	for these files within a 'views' directory, but this
	can be changed in the app.set innvocation if desired)
*/
app.set('view engine', 'pug');

app.get('/', function(req, res) { 
	/**
		'res.render' will go into the views directory (or whatever
		other directory was specified in app.set) and find a file
		with the name of it's argument and render it as a template
	*/
	res.render('index'); // will look for views/index.pug
});

app.get('/person/:name', function(req, res) { 
	/**
		'res.render' can also take data to pass to the
		template as a second argument
	*/
	res.render('person', { name: req.params.name }); // will pass :name to views/person.pug
});

app.listen(PORT);

















