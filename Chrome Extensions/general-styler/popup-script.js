(function() {
	var textInput = document.querySelector('.TextInput');
	var submitButton = document.querySelector('.SubmitButton');

	var div = document.createElement('div');
	div.className = 'GeneralStyler';
	document.body.append(div);

	submitButton.addEventListener('click', function() {
		var style = document.createElement('style');
		style.innerHTML = textInput.value;
		
		div.children().forEach(function(el) {
			el.remove();
		});
		div.append(style);
	});
}());