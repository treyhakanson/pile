# Advanced PostGreSQL Topics

## Overview

more advanced SQL commands to perform more complex queries and manipulations

## Topics

### Timestamps

the `extract` function can be used to extract pieces of a timestamp:

```sql
SELECT extract(<unit> from <timestamp_col>) FROM <table>;
```

units that can be extracted:

- **day** - day of the month
- **dow** - day of the week (0=Sunday -> 6=Saturday)
- **doy** - day of the year (1-365/366, depending on if leap year)
- **epoch** - number of _seconds_ since 1970-01-01 00:00:00 UTC if date value, number of _seconds_ in interval if interval value
- **hour** - hour (0-23)
- **microseconds**
- **millenium**
- **minute** - minute (0-59)
- **month** - number for the month (1-12) if date value, number of months (0-11) if interval value
- **quarter** - quarter (1-4)
- **second** - also includes fractional seconds
- **week** - number of the week of the year based on ISO 8601 (specifies that the year begins on the week containing January 4th)
- **year** - year as 4-digits

arithmetic can be performed on datetime objects as well, check out [PostGreSQL's documentation](https://www.postgresql.org/docs/9.6/static/functions-datetime.html) form more information on adding and subtracting intervals, times, integers, etc.

### Mathematical Functions

a list of all mathematical operators in PostGreSQL can be found [here](http://www.postgresql.org/docs/9.6/static/functions-math.html)

keep in mind that division will return integers, not floats

### String Functions

a list of all string functions in PostGreSQL can be found [here](http://www.postgresql.org/docs/9.6/static/functions-string.html)

strings are not "added together" using `+`, the are concatenated with `||`

### Subqueries

A subquery allows for multiple `SELECT` statements to be used within a single query

can be placed in something like a `WHERE` clause to create more powerful queries

### Self Join

used when the goal is to combine rows with other rows in the same table

requires the use of an alias

example:

```sql
SELECT e1.employee_name
FROM employee AS e1, employee AS e2
WHERE
e1.employee_location = e2.employee_location
AND e2.employee_name = 'J
ohn';
```

self joins are useful when a table has columns that reference data within itself. For example, if a table of members had a "referred_by" column that consisted of a member id

### Schemas

if there are multiple schemas for a database, need to specify which is being used

```sql
SELECT <col> FROM <schema>.<table>;
```

### CASE statements

`CASE` statements in Postgres are generic conditional expressions, similar to if/else statements in other programming languages:

```sql
-- if this <condition> is matched, return <result>
CASE WHEN <val>=<condition> THEN <result>
     WHEN <val>=<other_condition> THEN <other_result>
     ...
     -- acts as the default case
     ELSE <default>
END
```

cases are added to the column selection portion of a `SELECT` statement and will show up as a column in the result of the query

there is also an alternate form of the `CASE` statement that looks more similar to a switch case as opposed to an if/else:

```sql
CASE <val> 
    WHEN <condition> THEN <result>
    WHEN <other_condition> THEN <other_result>
    ...
    ELSE <default>
END
```

can only name the column created by a `CASE` statement using `AS` after `END`

important to note the the resulting column from a `CASE` statement cannot be used in a `WHERE` clause

### Casting

casting to a specific type in Postgres can be valuable, and there are two available syntaxes to do so:

```sql
-- Postgres specific syntax
SELECT '2012-08-31 01:00:00'::timestamp;

-- Standard SQL syntax (works in Postgres)
SELECT cast('2012-08-31 01:00:00' AS timestamp);
```
