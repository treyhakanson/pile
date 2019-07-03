var express = require('express');
var path = require('path');
var bodyParser = require('body-parser');
var http = require('http');

var app = express();
app.set('views', './src/views');
app.set('view engine', 'ejs');
app.use('/public', express.static(path.join(__dirname, '../public')));
app.use('/vendor', express.static(path.join(__dirname, '../bower_components')));

var port = process.env.PORT || 8080;
var server = app.listen(port, () => {
	console.log('Server Started.');
});

app.get('/', (req, res) => {
	res.render('index-3');
});

app.post('/make-video', bodyParser.json(), (req, res) => {
	
	console.log

});
