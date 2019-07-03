// Greetr is a greeting library
	// supports English and Spanish
	// supports jQuery
	// called with G$()
	// generates formal and informal greetings

// before any functionality was added, the basic structure was setup:
	// IIFE enclosing framework so as to not expose everything to the
	// global object
	// create the Greetr object and then the init method to prevent 
	// constantly having to call the 'new' keyword
	// sync up the prototypes of the init and the Greetr objects
	// expose Greetr and the G$ alias to the global object
	// finally, functionality was added to the method prototype

// using this IIFE structure prevents the js from being exposed to the global object 
// the initial semicolon is precautionary, incase the code preceding the IIFE doesn't
// end its line properly
;(function(global, $) {

	var Greetr = function(firstname, lastname, language) {
		return new Greetr.init(firstname, lastname, language);
	}

	// variables we don't want to expose in any way to developers using the frameworks,
	// (this prevents developers from editing them without changing the source code) 
	// but that we want to use within functions in the framework
	var supportedLangs = ["en", "es"];
	var greetings = {
		en: "Hello",
		es: "Hola"
	};
	var formalGreetings = {
		en: "Greetings",
		es: "Saludos"
	};
	var logMessages = {
		en: "Logged in",
		es "Inicío sesíon"
	};

	Greetr.prototype = {
		fullName: function() {
			return this.firstname + ' ' + this.lastname;
		}, // don't forget the comma!

		validate: function() {
			if (supportedLangs.indexOf(this.language) === -1) throw "Invalid Language";
		},

		greeting: function() {
			return greetings[this.language] + ' ' + this.firstname + '!';
		},

		formalGreeting: function() {
			return formalGreetings[this.language] + ', ' + this.fullName();
		},

		greet: function(formal) {
			var msg;

			if (formal) {
				msg = this.formalGreeting();
			} else {
				msg = this.greeting();
			}

			if (console) { // check for console because IE actually doesn't have one unless the dev tools are open
				console.log(msg);
			}

			return this; // returning 'this' makes the 'greet' method chainable

		},

		log: function() {
			if (console) {
				console.log(logMessages[this.language] + ': ' + this.fullName());
			}

			return this;

		},

		setLang: function(lang) {
			this.language = lang;
			this.validate();

			return this;

		},

		HTMLGreeting: function(selector, formal) {
			if (!$) throw "jQuery is Unavailable";
			if (!selector) throw "No Selector Given";

			var msg = (formal) ? this.formalGreeting() : this.greeting();
			$(selector).text(msg);

			return this;

		}

	};

	Greetr.init = function(firstname, lastname, language) {
		this.firstname = firstname || "buddy";
		this.lastname  = lastname  || "";
		this.language  = language  || "en";
	}

	Greetr.init.prototype = Greetr.prototype;

	// should check if Greeter and aliases are already present on the global object
	// before attaching, but won't here

	// both Greetr and G$ are now on the global object and point to the Greetr constructor 
	// (which calls the new keyword for us)
	global.Greetr = global.G$ = Greetr;

}(window, $ || jQuery));




















