/*
	This is a good example of the `extract` function and
	timestamp manipulation

	PROBLEM:
	Produce a list of the total number of slots booked per
	facility per month in the year of 2012. Produce an output
	table consisting of facility id and slots, sorted by the
	id and month.

	QUESTION: I only knew to use `facid` and `month` in the
	`GROUP BY` statement because an error was thrown if it
	wasn't. What does grouping by multiple columns mean
	conceptuallY? 

	QUESTION: On a similar note, what does this mean in an
	`ORDER BY` statement? Does it use the second column as a 
	tie-breaker?
*/

-- [example](https://www.pgexercises.com/questions/aggregates/fachoursbymonth2.html)
SELECT facid, extract(month from starttime) AS month, SUM(slots) "Total Slots"
	FROM cd.bookings
	WHERE extract(year from starttime) = '2012'
	-- grouping by 2 columns?
	GROUP BY facid, month
-- ordering by 2 columns?
ORDER BY facid, month ASC;

/*
	Only intersting thing to note here is that a `CASE`
	statement can be used within an aggregate function

	PROBLEM: Produce a list of facilities along with their 
	total revenue. The output table should consist of facility 
	name and revenue, sorted by revenue. Remember that there's 
	a different cost for guests and members!
*/

--[example](https://www.pgexercises.com/questions/aggregates/facrev.html)
SELECT facs.name, SUM(
	CASE bks.memid
		WHEN 0 THEN facs.guestcost * bks.slots
  		ELSE facs.membercost * bks.slots
  	END
  ) revenue
  FROM 
  	cd.facilities facs
	JOIN cd.bookings bks
		ON bks.facid = facs.facid
  GROUP BY facs.name
ORDER BY revenue;

/*
	This question brings up a pretty fundamental QA; it appears
	that SQL cannot use aggregate functions in `WHERE` because they
	are not evaluted until _after_ the WHERE clause. This would
	lead me to believe that the selection of the columns is actually
	the last part of the query that occurs. This also makes sense since
	alises that aren't set until the `FROM` clause can be used in the
	column specification. See [here](https://www.postgresql.org/docs/9.5/static/tutorial-agg.html) 
	in the documentation for a bit more on aggregate functions.

	QUESTION: What is the order of execution for a SQL query?
	Does the column selection and computation of aggregate functions
	occur last? Is this also the difference between `WHERE` and
	`HAVING`: that a `HAVING` can use an aggregate function
	because it occurs after the `GROUP BY` and thus the columns
	and preceding logic **must** have been executed at this point?
*/

-- [first appointment after date](https://www.pgexercises.com/questions/aggregates/nbooking.html)
SELECT surname, firstname, mems.memid, MIN(starttime)
	FROM
		cd.members mems
		JOIN cd.bookings bks
			ON bks.memid = mems.memid
	WHERE starttime > '2012-09-01'	 	
	GROUP BY firstname, surname, mems.memid
ORDER BY mems.memid ASC;