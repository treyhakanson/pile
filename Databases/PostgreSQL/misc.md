# Miscallaneous Functions

## Overview

a list of random, useful functions in Postgres

## Functions

- `max` gives the max value of a column
    - `max(<col>)`

## Statements and Clauses

`GROUPING SETS` allow for the creation of more complex grouping operations. Data selected by the `FROM` and `WHERE` clauses is grouped separately by each specified grouping set, aggregates computed for each group just as for simple `GROUP BY` clauses, and then the results returned.

see more information on grouping sets and helper functions [here](https://www.postgresql.org/docs/devel/static/queries-table-expressions.html#queries-grouping-sets):

```sql
SELECT * FROM items_sold;
```
| brand | size | sales |
| :---: | :--: | :---: |
| Foo   | L    |  10   |
| Foo   | M    |  20   |
| Bar   | M    |  15   |
| Bar   | L    |  5    |

```sql
SELECT brand, size, sum(sales) 
    FROM items_sold 
    GROUP BY GROUPING SETS (
        (brand), (size), ()
    );
```
| brand | size | sales |
| :---: | :--: | :---: |
| Foo   |      |  30   |
| Bar   |      |  20   |
|       | L    |  15   |
|       | M    |  35   |
|       |      |  50   |

`ROLLUP` and `CUBE` provide shorthand for certain cases of `GROUPING SETS`:

`ROLLUP` example:
```sql
-- shorthand using `ROLLUP`
ROLLUP ( e1, e2, e3, ... )

-- equivalent `GROUPING SETS` expression
GROUPING SETS (
    ( e1, e2, e3, ... ),
    ...
    ( e1, e2 ),
    ( e1 ),
    ( )
)
```
`CUBE` example:
```sql
-- cube clause
CUBE ( e1, e2, ... )

-- represents all possible subsets (power set)
CUBE ( a, b, c )

-- equivalent `GROUPING SETS` expression
GROUPING SETS (
    ( a, b, c ),
    ( a, b    ),
    ( a,    c ),
    ( a       ),
    (    b, c ),
    (    b    ),
    (       c ),
    (         )
)
```

without `GROUPING SETS`, one would have to resort to a pretty gnarly solution, such as using multiple queries joined with `UNION ALL` statements