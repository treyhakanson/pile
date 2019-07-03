/*
	window functions operate on the result set of a query, after
	`WHERE` clauses and all standard aggregation. Thus, they operate
	on a _window_ of data. By default this is unrestricted: the entire
	result set, but it can be restricted to provide more useful
	results. But, this can be changed to operate only over a specific
	set, as is soon in the examples below. Also keep in mind that
	window function act over rows in a result set.

	QUESTION: need more practice with these, they're a little confusing

	PROBLEM:
	Produce a list of member names, with each row containing the total member count. Order by join date.
*/

-- [approaches](https://www.pgexercises.com/questions/aggregates/countmembers.html)

/*
	`COUNT` normally would not be able to be used here,
	because it would attempt to collapse the table. but
	the over function makes it work like a sub-query, which
	can be a scalar value and will just be applied to all
	rows
*/
SELECT COUNT(*) OVER(), firstname, surname
	FROM cd.members
ORDER BY joindate 

-- here is the subquery alternative
SELECT (
		SELECT COUNT(*) FROM cd.members
	) AS count, firstname, surname
	FROM cd.members
ORDER BY joindate

/*
	`window functions also allow for restriction of the data set;
	here, the data is partitioned by month. For each row the window
	function operates over, the window is any rows that have a
	joindate in the same month. Thus, the window function produces
	a count of the number of members who joined in that month.
*/
SELECT COUNT(*) OVER(partition by date_trunc('month', joindate)),
	firstname, surname
	FROM cd.members
ORDER BY joindate

-- `ORDER BY` can also be used to further define the
-- window function; this one for example will only count
-- up to the current row, and not beyond, resulting in
-- the number joinee someone was in a given month
SELECT COUNT(*) OVER(partition by date_trunc('month',joindate) ORDER BY joindate),
	firstname, surname
	FROM cd.members
ORDER BY joindate
