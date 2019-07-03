const express 		= require('express');
const bodyParser 	= require('body-parser');
const morgan 		= require('morgan');
const mongoose 	= require('mongoose');
const jwt 			= require('jsonwebtoken');

const config 	= require('./config.js');
const User 		= require('./app/models/User');

mongoose.connect(config.database);

const port = process.env.PORT || 8080;
const app = express();
app.set('secret', config.secret);
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(morgan('dev')); // this is for dev purpose; just logs requests to the console

app.get('/', function(req, res) {
	res.send(`The api is running at http://localhost:${port}/api`);
});

// create a user for testing and such
app.get('/setup', function(req, res) {
	const testUser = new User({
		name: 'Trey Hakanson',
		password: 'password', // obviously in actuallity would never save a plaintext password in a db
		admin: true
	});

	testUser.save(function(err, result) {
		if (err) throw err;
		else res.json(result);
	});
});

// API ROUTES -----------------------------------
const apiRoutes = express.Router();

// middleware to verify a token
apiRoutes.use(function(req, res, next) {
	const token = req.body.token || req.query.token || req.headers['x-access-token'];
	if (token) {
		jwt.verify(token, app.get('secret'), function(err, decoded) {
			if (err) res.json({ success: false, message: 'Failed to authenticate token' });
			else {
				req.decoded = decoded; // adds a 'decoded' key to all routes
				next();
			}
		});
	} else return res.status(403).send({
		success: false,
		message: 'A valid token is required to use the api'
	});
});

apiRoutes.get('/', function(req, res) {
	res.json({ message: 'This is the root of the example api' });
});

apiRoutes.get('/users', function(req, res) {
	User.find({}, function(err, users) {
		if (err) throw err;
		else res.json(users);
	});
});

apiRoutes.post('/authenticate', function(req, res) {
	User.findOne({ name: req.body.name }, function(err, user) {
		if (err) throw error;
		else if (!user) res.json({ 
			success: false, 
			message: 'No User Found.' 
		});
		else if (user.password != req.body.password) res.json({ 
			success: false, 
			message: 'Inocorrect Pasccsword.' 
		});
		else {
			const token = jwt.sign(user, app.get('secret'), {
				expiresIn: "1 day"
			});

			res.json({
				success: true,
				message: 'You are now authorized to use the api with the following token.',
				token
			});
		}
	});
});

app.use('/api', apiRoutes);

app.listen(port, function() {
	console.log(`the server is running at http://localhost:${port}`);
});