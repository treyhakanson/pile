const express = require('express');
const path = require('path');

const port = process.env.PORT || 8080;
const app = express();

app.use('/assets', express.static(path.resolve(__dirname, 'public')));
app.use('/vendor', express.static(path.resolve(__dirname, 'bower_components')));

app.get('/', function(req, res) {
	console.log('SERVER HIT');
	res.sendFile(path.resolve(__dirname, 'public', 'index.html'));
});

app.listen(port, function() {
	console.log(`Server is running at localhost:${port}`);
});