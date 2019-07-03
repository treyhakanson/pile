# Basic Token Authentication Application
This application is a simple Node application using JWT to autheticate routes.
Uses a few packages to get things running:
* *express* Node framework
* *mongoose* interacting with the mongodb database
* *morgan* logs requests to the console so that its easy to keep track of what's happening
* *body-parser* allows parameters to be retrieved from the body of POST, PUT, etc. requests
* *jsonwebtoken* used to create and verify json tokens