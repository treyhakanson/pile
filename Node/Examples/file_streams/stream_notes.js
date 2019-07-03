/**
	Streams inherit from the event emitter

	There are a few types of streams:
		- Readable: can only read from the stream
		- Writable: can only write to the stream
		- Duplex: can both read from or write to the stream
		- Transform: can manipulate chunks in the stream as 
			they come accross
		- PassThrough: An implmentation of the transform stream
			that passes the input through to the output. Useful
			for testing and/or creating novel new types of 
			streams.
	
	Important to keep in mind that none of these streams are
	physically different, eg. a readable stream is not
	somehow different in a way that would make it unwritable.
	The types of stream are only perspective to the system
	creating them

*/

// NOTE: large_file.txt is a ~72kb file of Lorem Ipsum text
var fs = require('fs');
var path = require('path');

/**
 	The readable will load the file's data into a buffer,
 	and upon filling said buffer, will emit a data event 
 	(it can do this because it inherits from EventEmitter).
 	Using 'on', a callback can be binded to this event
 	to fire whenever it is executed (it will receive the
 	raw binarary data currently stored in the buffer, unless
 	an encoding is specified, then it gives actual text)
*/

/**
	the last argument is a dictionary of options for the stream (encoding, buffer size, etc.)
	highWaterMark -> buffer size (the example below is a 32kb buffer)
	lowering the buffer size can be good because it decreases the amount of data
	that will be added to the application heap by the buffer (the heap is where all
	buffers are allocated memory).
*/
var readable = fs.createReadStream(path.join(__dirname, 'large_file.txt'), { encoding: 'utf8', highWaterMark: 32 * 1024 });
var writable = fs.createWriteStream(path.join(__dirname, 'large_file_copy.txt'));

readable.on('data', function(chunk) {
	console.log(chunk); 		// will be a string in this case because encoding is specified
	writable.write(chunk); 	// will wite the data in the buffer to the file specified by the writable (large_file_copy.txt)
});










