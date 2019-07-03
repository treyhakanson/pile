angularApp.service('cityService', function() {
	this.cityName = localStorage.getItem('cityName');
	
	this.updateCity = function(cityName) {
		this.cityName = localStorage.setItem('cityName', cityName);
		return true;
	}
});