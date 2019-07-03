// use the "content-script" property to inject code into every page that is visited (you don't
// have to click the extensions icon or anything)
// example:
	...
	"content_scripts": [
		{
		  "matches": ["https://*/*"],
		  "css": ["stylesheet.css"],
		  "js": ["app.js"]
		}
	]
	...

	// see more at https://developer.chrome.com/extensions/content_scripts

// use programatic injection to inject scripts upon a specific interaction
	...
	"permissions": [
		
	]