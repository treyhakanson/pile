// putting all methods and such from a modules into a object
// to minimize collisions on the global object

object = {
	prop: 'some value',
	anotherProp: 'another value',
	someFunction: function() {
		return 'some return statement';
	}
}

object.prop // prevents 'prop' and other variables from being on the global
// object, and potentially clashing with other globals

// to really ensure you're preventing namespace collisons,
// can utilize a long reverse-com style namespace (this is only
// for when you ABSOLUTELY NEED something on the global object,
// which should be pretty rare)
var com = com || {};
com.treyhakanson = com.treyhakanson || {};
com.treyhakanson.javascript = com.treyhakanson.javascript || {};
com.treyhakanson.javascript.projects = {
	prop: 'some value',
	anotherProp: 'another value',
	someFunction: function() {
		return 'some return statement';
	}
}

// to completely control namespace, use
// an IIFE with whatever globals are needed
// passed in. This way, you can create public
// apis from within an enclosed environment
(function(window, document, jQuery) {
	
	// all code in here will be obsfucated from
	// the global context, here's an example
	// module:
	var module = {  }; // obsfucated

	// creating a public api from within a private
	// context
	if (!window.moduleName) // this means that namespace on the global object is available:
		window.moduleName = module;
	else // can throw an error if needed
		throw { name: 'Error 1', message: '"moduleName" is already present on the global object.' };

}(window, document, jQuery /* or any other global module */))




















