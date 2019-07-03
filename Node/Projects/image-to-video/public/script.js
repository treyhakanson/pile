var colors = ['red', 'blue', 'yellow', 'green', 'purple', 'cyan'];

for (var i = 0; i < colors.length; i++) {
	var canvas = document.createElement('canvas');
	canvas.height = canvas.width = 200;

	var ctx = canvas.getContext('2d');
	ctx.beginPath();
  ctx.fillStyle = colors[i];
  ctx.rect(50, 50, 100, 100);
  ctx.fill();

  document.querySelector('.images').append(canvas);
}

document.querySelector('.convert').addEventListener('click', function(event) {
	var canvases = Array.from(document.querySelectorAll('.images canvas'));

	var promise = new Promise((resolve, reject) => {
		
		var blobUrls = [];

		canvases.forEach((canvas, i) => {

			canvas.toBlob(blob => {

				var url = URL.createObjectURL(blob);
				blobUrls.push(url);

				if (blobUrls.length === canvases.length)
					resolve(blobUrls);

			});

		});

	});

	promise.then(blobUrls => {
		
		axios.post('/make-video', {
			urls: blobUrls
		}).then(data => {
			
			console.log(data);

			blobUrls.forEach(blobUrl => {

				URL.revokeObjectURL(blobUrl);

			});

		});

	});

});
