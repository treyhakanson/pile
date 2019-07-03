/**
	Pipe: connecting to streams by writing to one stream
		what is being read from another. (In Node, Readable
		streams are piped to Writable streams)

	Pipes can be chained, connecting many stream (The first
	stream being piped from needs to be readable)

*/

var fs = require('fs');
var path = require('fs');
var zlib = require('zlib'); // Node's built in compression lib (compresses to gzip)

var readable = fs.createReadStream(path.join(__dirname, 'large_file.txt'));
var writable = fs.createWriteStream(path.join(__dirname, 'large_file_pipe_copy.txt'));

// the gzip stream simply outputs data, it needs to be piped and written
// elsewhere
var compressed = fs.createWriteStream(path.join(__dirname, 'large_file_comp.txt.gz'));

/**
	this object is a transform stream; it compresses the 
	data as it comes into the buffer, and can be piped
	to/from because it is both readable and writable
*/
var gzip = zlib.createGzip();

/**
	all readable streams have a 'pipe' method
	on their prototype which takes in a destination
	stream (must be writable) and a set of options 
	for the pipe. The pipe will also return the
	destination stream after it does all the setup
	it needs to.

	Also, because 'pipe' returns the destination 
	stream, it's very easy to chain streams:
	s1.pipe(s2).pipe(s3)...pipe(sn);
*/
readable.pipe(writable);
readable.pipe(gzip).pipe(compressed);

// chaining 	-> returns an object to work on
// cascading 	-> a form of chaining where the initial parent is returned (think jQuery)








