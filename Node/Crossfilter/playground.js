(function() {

	/*
		
		NOTES
		---------------------------------------------------------
		8 dimens and 16 dimens are checpoints for adding overhead,
		and only 32 dimens are currently allowed

	*/
	
	// clear the console
	console.log('\033[2J');

	console.log('--------------------------------');
	console.log('-------- PROGRAM OUTPUT --------');
	console.log('--------------------------------\n');

	var crossfilter = require('crossfilter');

	var payments = crossfilter([
		{date: "2011-11-14T16:17:54Z", quantity: 2, total: 190, tip: 100, type: "tab"},
		{date: "2011-11-14T16:20:19Z", quantity: 2, total: 190, tip: 100, type: "tab"},
		{date: "2011-11-14T16:28:54Z", quantity: 1, total: 300, tip: 200, type: "visa"},
	  {date: "2011-11-14T16:30:43Z", quantity: 2, total: 90, tip: 0, type: "tab"},
		{date: "2011-11-14T16:48:46Z", quantity: 2, total: 90, tip: 0, type: "tab"},
		{date: "2011-11-14T16:53:41Z", quantity: 2, total: 90, tip: 0, type: "tab"},
		{date: "2011-11-14T16:54:06Z", quantity: 1, total: 100, tip: 0, type: "cash"},
		{date: "2011-11-14T16:58:03Z", quantity: 2, total: 90, tip: 0, type: "tab"},
		{date: "2011-11-14T17:07:21Z", quantity: 2, total: 90, tip: 0, type: "tab"},
		{date: "2011-11-14T17:22:59Z", quantity: 2, total: 90, tip: 0, type: "tab"},
		{date: "2011-11-14T17:25:45Z", quantity: 2, total: 200, tip: 0, type: "cash"},
		{date: "2011-11-14T17:29:52Z", quantity: 1, total: 200, tip: 100, type: "visa"}
	]);

	// size
	console.log(`payments.size() = ${payments.size()}\n`);

	var paymentsByTotal = payments.dimension(d => d.total);

	// NOTE: calling 'filter' replaces any existing filters on the dimension
	paymentsByTotal.filter(100); // === 100
	paymentsByTotal.filter([75, 100]); // in [75 and 100)
	paymentsByTotal.filter(tip => tip % 3 === 0); // divisble by 3
	paymentsByTotal.filter(null); // clears filters

	// calling remove removes all elements matching the current filters
	// payments.remove();
	
	paymentsByTotal.top(3); // 3 highest tips (array)
	paymentsByTotal.bottom(3); // 3 lowest tips (array)

	console.log(paymentsByTotal.groupAll().value());

	// removes the dimens, freeing up space for other dimens
	// paymentsByTotal.dispose();
	
	// group bys only honor filters of other dimensions, not the dimension
	// being grouped by; thus, this will ignore any filters on total but
	// would honor a filter on something else, like tip
	var paymentGroupsByTotal = paymentsByTotal.group(total => Math.floor(total / 100));

	console.log('------------------');
	console.log('Group Information:');
	console.log('------------------');
	console.log(`Group:\n${
		paymentGroupsByTotal.all() // get all groups
			.map(x => `\tgroup = ${x.key}\n\tcount = ${x.value}`)
			.join('\n\n')}`);
	console.log(`\nGroup Count: ${paymentGroupsByTotal.size()}`);
	console.log('------------------');

	// dispose of the group
	// paymentGroupsByTotal.dispose();

	console.log('\n--------------------------------');

}());

