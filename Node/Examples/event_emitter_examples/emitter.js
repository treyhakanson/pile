function Emitter() {
	this.events = {};
}

// adds event listeners to specific types of events.
// these are kept in an array so that multiple listeners
// can be stored to be executed on a single event
// being triggered
Emitter.prototype.on = function(type, listener) {
	// if the property exists, use it, and if it doesn't, 
	// make it an empty array. Then add the listener to 
	// the list of functions to execute on an event of
	// 'type' being triggered
	this.events[type] = this.events[type] || [];
	this.events[type].push(listener);
};

Emitter.prototype.emit = function(type) {
	// if there are listeners available for
	// this event type, run them all (in order
	// of being added)
	if (this.events[type])
		this.events[type].forEach(function(listener) {
			listener();
		});
}

module.exports = Emitter;