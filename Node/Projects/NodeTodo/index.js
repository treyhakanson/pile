const express = require('express');
const mongoose = require('mongoose');
const path = require('path');
const setupController = require('./controllers/SetupController');
const apiController = require('./controllers/ApiController');

const app = express();
app.use('/assets', express.static(path.join(__dirname, 'public')));
app.set('view engine', 'pug');

mongoose.connect('mongodb://127.0.0.1:27017');

setupController(app);
apiController(app);

const port = process.env.PORT || 8080;
app.listen(port, function() {
	console.log('application is successfully running on port', port);
});