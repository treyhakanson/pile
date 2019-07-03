const canvas = document.createElement('canvas');

// dimens of heatmap.jpg
canvas.height = 703;
canvas.width = 1280;

const ctx = canvas.getContext('2d');
const img = new Image();

img.onload = () => {
	ctx.drawImage(img, 0, 0);
	document.body.append(canvas);

	const watermark = generateWatermark(canvas.width, canvas.height);
	ctx.drawImage(watermark, 0, 0)

};

img.src = 'http://localhost:8080/public/heatmap.jpg';

function generateWatermark(width, height) {
    const canvas = document.createElement('canvas');
    const watermarkWidth = 350;
    const watermarkHeight = 90;

    canvas.height = height;
    canvas.width = width;

    const ctx = canvas.getContext('2d');

    ctx.beginPath();
    ctx.fillStyle = 'white';
    ctx.rect(width - watermarkWidth, 0, watermarkWidth, watermarkHeight);
    ctx.fill();

		ctx.fillStyle = 'black';

		const text = 'made with ❤ on crossroads';
    ctx.font = `25px Helvetica`;
		const { width: textWidth } = ctx.measureText(text);

    ctx.fillText(text, width - (watermarkWidth / 2 + textWidth / 2), 30);

    const date = '12 August 2016';
    ctx.font = `25px Helvetica`;
		const { width: dateWidth } = ctx.measureText(date);

    ctx.fillText(date, width - (watermarkWidth / 2 + dateWidth / 2), 70);

    return canvas;
}
