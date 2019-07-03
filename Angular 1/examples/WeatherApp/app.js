// MODULE
var weatherApp = angular.module('weatherApp', ['ngRoute', 'ngResource']);

// ROUTING CONFIG
weatherApp.config(function($routeProvider) {
    $routeProvider
    
    .when('/', {
        templateUrl: 'pages/home.htm',
        controller: 'homeController'
    })
    
    .when('/forecast', {
        templateUrl: 'pages/forecast.htm',
        controller: 'forecastController'
    })
    
    .when('/forecast/:cnt', {
        templateUrl: 'pages/forecast.htm',
        controller: 'forecastController'
    });
        
});

weatherApp.service('forecastService', function() {
    this.cityName = 'Columbus';
});

weatherApp.service('weatherService', ['$resource', function($resource) {
    // by settings the weather api call as a resource, we're telling
    // the browser that it's ok to get data from this location. This
    // way the application doesn't think this is a hack attempt or
    // something; it's expecting this type of call
    this.getWeather = function(cityName, cnt) {        
        var weatherAPIBase = 'http://api.openweathermap.org/data/2.5/forecast/daily';
        var weatherAPI = $resource(weatherAPIBase, { callback: 'JSON_CALLBACK' }, { get: { method: 'JSONP' } });
        
        return weatherAPI.get({
            // calling the resource with the following
            // query strings:
            q: cityName,
            cnt: cnt,
            units: 'metric',
            APPID: 'dfba8c406098a4963de7acd6adf1dfbe'
        });
        
    }
    
}]);

weatherApp.directive('weatherPanel', function() {
   return {
       templateUrl: 'directives/weather-panel.html',
       replace: true,
       scope: {
           result: '=',
           convertToDate: '&',
           dateFormat: '@'
       }
   } 
});

// CONTROLLERS
weatherApp.controller('homeController', ['$scope', '$location', 'forecastService', function($scope, $location, forecastService) {
    
    $scope.cityName = forecastService.cityName;
    
    $scope.$watch('cityName', function() {
        forecastService.cityName = $scope.cityName;
    });
    
    $scope.submit = function() {
        $location.path('/forecast');
    }
    
}]);

weatherApp.controller('forecastController', ['$scope', '$routeParams', 'forecastService', 'weatherService', function($scope, $routeParams, forecastService, weatherService) {
    
    $scope.cityName = forecastService.cityName;
    $scope.cnt = $routeParams.cnt || '2'; // $routeParams are strings
    
    $scope.convertToDate = function(dt) {
        return new Date(dt * 1000);
    }
    
    $scope.weatherResult = weatherService.getWeather($scope.cityName, $scope.cnt);
    
}]);


























