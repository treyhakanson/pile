var angularApp = angular.module('angularApp', ['ngRoute', 'ngResource']);

angularApp.config(['$sceDelegateProvider', function($sceDelegateProvider) {
	$sceDelegateProvider.resourceUrlWhitelist([
		'self',
		'http://api.openweathermap.org/data/2.5/forecast/daily'
	]);
}]);