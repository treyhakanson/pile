// app.all allows for middleware to be applied to specific
// routes
app.all(function(req, res, next) {
	// do something (maybe log, stats, etc.)
	next(); // go to the next handler (app.get, app.post, etc.)
});

/*
	string route paths can use a variant of regular expressions:
		?, +, *, () are interpreted as regexes
		. and - are interpreted literally
*/
app.get('/ab?cd', function(req, res) { // matches /abcd and /abd
	// do something
});

app.get('/ab+cd', function(req, res) { // matches /abcd, /abbcd, /abbbcd...
	// do something
});

// can also use standard regexes
app.get(/.*-user$/, function(req, res) { // matches /trey-user, /person-user, but not /user-person
	// do something
});

// can concat params with a hyphen (-), period (.), or anything else
// (these two are the most common)
app.get('/flights/:origin-:destination', function(req, res) { // matches /flights/LAX-JFK, etc.
	// do something
});

// callbacks can be stacked on any route (don't forget the next arg)
app.get('/some-route', function(req, res, next) {
	// do something
	next();
}, function(req, res) {
	// do something
});
// can stack with an array too
app.get('/some-route', [/* an array of function, calling next as needed */]);

// response methods
res.download(); 	// prompt a file to downloaded
res.end(); 			// end the response process
res.json(); 		// send a json response
res.jsonp(); 		// send a json response with jsonp support
res.redirect();	// Redirect a request.
res.render();		// Render a view template.
res.send();			// Send a response of various types.
res.sendFile();	// Send a file as an octet stream.
res.sendStatus();	// Set the response status code and send its string representation as the response body.

// app.route can be used for clarity in declaring the
// reactions to the different verbs on one endpoint
app.route('/book')
  .get(function (req, res) {
    res.send('Get a random book');
  })
  .post(function (req, res) {
    res.send('Add a book');
  })
  .put(function (req, res) {
    res.send('Update the book');
  });

// can use routers to handle specific routes and middleware for clarity
// and compartmentalization
var express = require('express')
var router = express.Router()

// middleware specific to 'router'
router.use(function timeLog (req, res, next) {
  console.log('Time: ', Date.now());
  next();
});
// route specific to 'router'
router.get('/all', function (req, res) {
  res.send('all birds');
});
module.exports = router;

// in the main app...
var birds = require('./birds')
app.use('/birds', birds) // binds all routes to /birds; so /all from below will be locations at /birds/all

// middleware can also be bound to a route in a separate block
app.use('/some-route', function(req, res, next) { // only runs at /some-route (any verb)
	// do something
	next();
});

// next('route') can be called from middle ware to skip all remaining
// calls in the stack and move on to the next route
app.get('/some-route', function (req, res, next) {
  if (/* some case */) next('route'); // calls the next '/some-route' GET block
  else next(); // moves to next call in stack vvvvv
}, function (req, res, next) { // corresponds to the else statement above
  res.render('regular'); 
});

// handler for the /some-route endpoint, only runs if the 'if'
// statement on the above block executes (otherwise this method
// would never run because the last call in the above route renders
// a page, thus delivering a response and ending the chain)
app.get('/some-route', function (req, res, next) {
  res.render('special')
});

// NOTE: all of the middleware methods above apply to both apps (express())
// and routers (express.Router())

// error handling middleware is defined as follows
// NOTE: define error handling middleware last so it will
// not occur until after all other middlewares have run
app.use(function(err, req, res, next) {
	console.error(err.stack);
	res.status(500).send('Something Broke!!'); // could also call next to move to the next call in the stack, if desired
});

// express.static is the only built in middleware, and it is highly configurable
// through [options]()
app.use(express.static('public', options));