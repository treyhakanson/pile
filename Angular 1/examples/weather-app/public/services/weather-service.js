angularApp.service('weatherService', ['$resource', function($resource) {
	this.apiBase = 'http://api.openweathermap.org/data/2.5/forecast/daily';
	
	var WeatherAPI = $resource(this.apiBase, {
		cnt: 2,
		units: 'metric',
		APPID: 'dfba8c406098a4963de7acd6adf1dfbe'	
	}, {
		jsonp: { method: 'JSONP' }
	});

	this.getWeather = function(cityName, cnt) {
		return WeatherAPI.jsonp({
			q: cityName,
			cnt: cnt
		});
	};

}]);