angularApp.controller('forecastController', [
	
	'$scope', '$routeParams', 'weatherService', 

	function($scope, $routeParams, weatherService) {
		if ($routeParams.cityName) {
			$scope.cityName = $routeParams.cityName

			var weather = weatherService.getWeather($scope.cityName, 5);
			console.log(weather);

		} else $scope.showError = true;
	}

]);