# Database Views

## Overview

a view is a database object that represents a stored query

a view can be accessible as a virtual table in PostGreSQL

in short, a view is a logical table that represents data of one or more underlying tables through a `SELECT` statement

keep in mind that this concept is largely specific to PostGreSQL, and views are not present in all flavors of SQL

a view does not store data physically, it more just represents a query

a view helps simplify compplex queries, because instead of reqriting said complex query, you are able to just query the view:

```sql
-- Original query
SELECT c1, c2, c3, c4, c5
FROM t1
JOIN t2 ON c1
JOIN t3 ON c2;

-- example of querying a view representing
-- the above query
SELECT * FROM example_view;
```

views are also useful for granting permissions; different types of users could be given access only to views of the data they should be allowed to see, rather than the underlying tables

A view also produces a consistent layer even if the columns of the underlying table change

## Creating Views

A view is created using the `CREATE VIEW` statement along with a query it is to represent:

```sql
-- "query" will be a `SELECT` statment
CREATE VIEW <view_name> AS <query>;
```

## Modifying Views

A view can be edited using the `ALTER VIEW` statement, along with various commands:

```sql
ALTER VIEW <view> <command>;
```

Commands include:

- `RENAME TO`

## Removing Views

Removing views is very similar to removing a table:

```sql
DROP VIEW IF EXISTS <view>;
```

keep in mind that dropping a table a view is dependent on will not remove it unless the `CASCADE` property is specified. In addition, the `RESTRICT` property can be used when dropping a table to prevent the action from occuring if a dependent view (or table) exists.


## Common Table Expressions (CTEs)

essentially create an inline view in a query. Good if a query involves repeated logic:

```sql
-- Without CTE
SELECT facid, sum(slots) totalslots
    FROM cd.bookings
    GROUP BY facid
    HAVING sum(slots) = (SELECT max(sum2.totalslots) FROM
        (SELECT sum(slots) totalslots
        FROM cd.bookings
        GROUP BY facid
        ) AS sum2);

-- with CTE
-- `sum` is the CTE here
WITH sum AS (SELECT facid, sum(slots) AS totalslots
    FROM cd.bookings
    GROUP BY facid
)
SELECT facid, totalslots
    -- `sum` is used multiple times 
    FROM sum
    WHERE totalslots = (SELECT max(totalslots) FROM sum);
```
