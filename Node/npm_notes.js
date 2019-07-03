/**
	npm -> node package manager

	'npm init' will create the boilerplate for
	a node module, and will run you through a few
	questions to setup the package.json

	--save -> will add to the dependencies in the
	package.json

	--save-dev -> will add to the dev-dependencies
	in the package.json

	dependency version notation:
		^ -> automatically update to anything within this
		major version (ex: ^2.1.9 will automatically update
		to 2.1.10 or 2.2.0)
		
		~ -> automatically update with any patches, but ignore
		minor updates (ex: ~2.1.9 will automatically update to
		2.1.10)

		can run 'npm update' to update all modules according
		to their modifier

	nodemon has a cli, and can be used to listen for changes
	in node files, and then restart the node server upon the
	change event being emmited (great because otherwise you'd
	have to manually cancel and restart the server any time
	you changed a file in order to see the effects)

		use it just like you would node (node app.js -> nodemon app.js)


*/