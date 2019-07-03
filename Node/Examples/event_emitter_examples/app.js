// The internal node event emitter is
// structured the exact same way as this,
// would just need to import 'events' instead
// of './emitter'

// import the Emitter
var Emitter = require('./emitter');

// instantiate an Emitter object
var emtr = new Emitter();

// bind a couple of listeners to the
// 'greet' event
emtr.on('greet', function() {
	console.log('Somewhere, someone said hello.');
});

emtr.on('greet', function() {
	console.log('A greeting ocurred!');
});

// will run both of the above functions
// upon emitting this greet event
emtr.emit('greet');
