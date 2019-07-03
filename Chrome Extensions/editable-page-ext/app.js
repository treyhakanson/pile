(function() {
	var btn = document.getElementById('#yes-button');
	btn.addEventListener('click', function() {
		chrome.tabs.executeScript(null, {file: "editing_script.js"});
	});
}());