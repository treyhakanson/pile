# Window Functions

## Overview

window functions operate on the result set of a query, after `WHERE` clauses and all standard aggregation. Thus, they operate on a _window_ of data. By default this is unrestricted: the entire result set, but it can be restricted to provide more useful results. Keep in mind that window function act over rows in a result set.

## Functions

`OVER` - used to specify a partition

`ROW_NUMBER` - used to specify row number; must be used with an `OVER` clause

`RANK` - gives each row a rank based on the companion `OVER` statements parameters. Note that if n rows tie for rank m, the next rank will be m + n. For example:

| row | value | rank |
| :-: | :---: | :--: |
| 1   | 10    | 1    |
| 2   | 10    | 1    |
| 3   | 10    | 1    |
| 4   | 5     | 4    |

`DENSE_RANK` will alter this behavior so that row 4 would have a rank of 2

