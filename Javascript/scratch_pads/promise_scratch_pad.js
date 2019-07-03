function sum(a, b) {
	var shouldSum = typeof a === 'number' 
		&& typeof b === 'number';

	return new Promise((resolve, reject) => {
		(shouldSum) ? 
			resolve(a + b) :
			reject('One of the arguments was not a number.');
	});
}

sum(2, 3)
	.then(sum => {
		console.log('the sum is:', sum);
	})
	.catch(error => {
		console.log('ERROR:', error);
	});

sum(2, '4')
	.then(sum => {
		console.log('the sum is: ', sum);
	})
	.catch(error => {
		console.log('ERROR: ', error);
	});