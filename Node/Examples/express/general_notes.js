/**
	there are multiple templating engines that can be 
	used with node/express. A few popular ones are:

	- jade (now pug): pugjs.org (strange syntax)
	- ejs: ejs.co (this one looks similar to django templating)
	- mustache: http://mustache.github.io/

	REST (Representational State Transfer): An architectural 
	style for building APIs where the HTTP verbs and urls
	mean something (they make sense when considering what
	actions they're performing)
		so /api/data would accept get, post, and delete verbs
		and act accordingly, instead of doing separate routes
		like /api/data/get, /api/data/delete, etc.

	express-generator is a CLI to quickly generate a good
	boilerplate for an express application (this boilerplate
	is an official package of express, so it's their 
	reccommendation)

	controller: sits between the data and the view and handles
	what views should be displaying for a particular set of
	data

	an interesting way of attaching routes is shown in lecture
	79 (a very module centric way of doing thinhgs). I prefer 
	the standard express way of using the Router middleware to 
	this, but it's still interesting to see
*/