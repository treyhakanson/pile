angularApp.config(function($routeProvider, $locationProvider) {
	$locationProvider.hashPrefix('');

	$routeProvider

	.when('/', {
		templateUrl: '/assets/pages/home.html',
		controller: 'homeController'
	})

	.when('/forecast', {
		templateUrl: '/assets/pages/forecast.html',
		controller: 'forecastController'
	})

	.when('/forecast/:cityName', {
		templateUrl: '/assets/pages/forecast.html',
		controller: 'forecastController'
	});

});