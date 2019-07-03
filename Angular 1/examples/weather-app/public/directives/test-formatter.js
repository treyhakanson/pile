angularApp.directive('testFormatter', function() {
	return {
		require: 'ngModel',
		link: function(scope, element, attrs, ctrl) {
			console.log('hello');
			function parser(val) {
				console.log('executed');
				return '~' + val + '~';
			}
			ctrl.$parsers.push(parser);
			console.log(ctrl.$parsers);
		}
	}
})