// MODULE
var angularApp = angular.module('angularApp', [/* 
	the apps dependencies go here; for example,
	if angular-message had been added as a script
	in the body, 'ngMessages' could be added here
	(all angular modules start with 'ng'`)	
*/]);

// CONTROLLERS
// BAD (NO MINIFICATION)
// the following are the same, because of angular's
// dependency injection will parse the function's
// arguments and get the corresponding service. this
// makes minification impossible, because the name of
// the arguments to the function is actually important
/**
	angularApp.controller('mainController', function ($scope, $log) {
	    
	});
	angularApp.controller('mainController', function ($log, $scope) {
	    
	});
*/

// GOOD (MINIFICATION POSSIBLE)
// passing an array as the second arg of a controller
// will perserve the order of services when passed to
// the function. This allowx for code to be minified
/**
angularApp.controller('mainController', ['$scope', '$log' function (a, b) {
    // a = $scope
    // b = $log
}]);
*/

angularApp.controller('twitterHandleController', ['$scope', '$filter', function($scope, $filter) {
	var _handle = '';
	Object.defineProperty($scope, 'handle', {
		get: function() { return $filter('lowercase')(_handle); },
		set: function(newValue) { _handle = newValue; }
	});
}]);