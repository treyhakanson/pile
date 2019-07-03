// combined canvas
const final = document.createElement('canvas');
final.width = 981;
final.height = 659;
const finalctx = final.getContext('2d');
finalctx.globalCompositeOperation = 'overlay';

// red heatmap image
let reddone = false;
const red = document.createElement('canvas');
red.width = 981;
red.height = 659;
const redctx = red.getContext('2d');

const redimg = new Image();
redimg.onload = () => {
	redctx.drawImage(redimg, 0, 0);
	if (bluedone) {
		finalctx.drawImage(blue, 0, 0);
		finalctx.drawImage(red, 0, 0);
	} else {
		reddone = true;
	}
};
redimg.src = 'http://localhost:8080/public/heatmap-red.png';

// blue heatmap image
const blue = document.createElement('canvas');
let bluedone = false;
blue.width = 981;
blue.height = 659;
const bluectx = blue.getContext('2d');

const blueimg = new Image();
blueimg.onload = () => {
	bluectx.drawImage(blueimg, 0, 0);
	if (reddone) {
		finalctx.drawImage(blue, 0, 0);
		finalctx.drawImage(red, 0, 0);
	} else {
		bluedone = true;
	}
};
blueimg.src = 'http://localhost:8080/public/heatmap-blue.png';

// add canvas to page
document.body.append(final);
