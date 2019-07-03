angularApp.controller('homeController', ['$scope', '$location', 'cityService', function($scope, $location, cityService) {
	$scope.cityName = cityService.cityName;
	$scope.showAlert = false;

	$scope.submit = function() {
		$location.path('/forecast/' + $scope.cityName);
	}

	$scope.makeDefault = function() {
		if (cityService.updateCity($scope.cityName))
			$scope.showAlert = true;
	}

}]);