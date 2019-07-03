/**
	protocol: a set of rules two sides agree to use 
		when communicating. 

	Both the client and the server agree to use 
	a specific protocal

	TCP: Transmission Communication Protocol
	this protocol is what splits the data
	from the server into multiple pieces
	and then sends it through a socket
	to the client in chunks, which are called
	packets (Node will treat this protocol as
	if it were a stream, which it essentially is)

	Port: once a computer receives a packet,
	how it knows what program to send it to;
	so when a program is setup on an OS to
	receive packets from a particular port, it
	is said that that program is 'listening' to
	that port

	a socket address is an ip followed by a port
	specification (0.0.0.0:8080)

	domain names map to an ip address and a port

	HTTP: a set of rules for data that is being transferred
	over the web (HyperText Transfer Protocol). It's a format
	defining data being transferred over TCP/IP

	MIMI Type: a standard for specifying the type of data
	being sent (Multipurpose Internet Mail Extensions)

*/