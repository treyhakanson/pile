# JOIN Clauses

joins relate data across multiple tables

## Types of JOIN Clauses

![Types of SQL JOIN Clauses](https://www.codeproject.com/KB/database/Visual_SQL_Joins/Visual_SQL_JOINS_orig.jpg)

example data (Tables A and B) for the purpose of explaining the different types of `JOIN` clauses:

| A.id        | A.name      | B.id        | B.name      |
| ----------- | :---------: | ----------- | :---------: |
| **1**       | Pirate      | **1**       | Rutabage    |
| **2**       | Monkey      | **2**       | Pirate      |
| **3**       | Ninja       | **3**       | Darth Vader |
| **4**       | Spaghetti   | **4**       | Ninja       |

---

an `INNER JOIN` produces only the set of records that matches in both Table A and Table B:

*QUERY:*

```sql
SELECT * FROM A
INNER JOIN B
ON A.name = B.name;
```

*DATA:*

| A.id        | A.name      | B.id        | B.name      |
| ----------- | :---------: | ----------- | :---------: |
| **1**       | Pirate      | **2**       | Pirate      |
| **2**       | Monkey      | `null`      | `null`      |
| **3**       | Ninja       | **4**       | Ninja       |
| **4**       | Spaghetti   | `null`      | `null`      |
| `null`      | `null`      | **1**       | Rutabage    |
| `null`      | `null`      | **3**       | Darth Vader |

---

an `INNER JOIN` produces only the set of records that matches in both Table A and Table B:

*QUERY:*

```sql
SELECT * FROM A
INNER JOIN B
ON A.name = B.name;
```

*DATA:*

| A.id        | A.name      | B.id        | B.name      |
| ----------- | :---------: | ----------- | :---------: |
| **1**       | Pirate      | **2**       | Pirate      |
| **3**       | Ninja       | **4**       | Ninja       |

---

an `LEFT OUTER JOIN` produces the set of all records from A, with matching records from B where available. If not available, the B side (right side) will contain `null`:

*QUERY:*

```sql
SELECT * FROM A
LEFT OUTER JOIN B
ON A.name = B.name;
```

*DATA:*

| A.id        | A.name      | B.id        | B.name      |
| ----------- | :---------: | ----------- | :---------: |
| **1**       | Pirate      | **2**       | Pirate      |
| **2**       | Monkey      | `null`      | `null`      |
| **3**       | Ninja       | **4**       | Ninja       |
| **4**       | Spaghetti   | `null`      | `null`      |

---

an `RIGHT OUTER JOIN` produces the set of all records from B, with matching records from A where available. If not available, the A side (left side) will contain `null`. Essentially the opposity of a `LEFT OUTER JOIN`.

---

an `LEFT OUTER JOIN` with `WHERE` produces the set of records only in A

*QUERY:*

```sql
SELECT * FROM A
LEFT OUTER JOIN B
ON A.name = B.name
WHERE B.id IS null;
```

*DATA:*

| A.id        | A.name      | B.id        | B.name      |
| ----------- | :---------: | ----------- | :---------: |
| **2**       | Monkey      | `null`      | `null`      |
| **4**       | Spaghetti   | `null`      | `null`      |

---

an `LEFT OUTER JOIN` with `WHERE` produces the set of records only in A

*QUERY:*

```sql
SELECT * FROM A
LEFT OUTER JOIN B
ON A.name = B.name
WHERE B.id IS null;
```

*DATA:*

| A.id        | A.name      | B.id        | B.name      |
| ----------- | :---------: | ----------- | :---------: |
| **2**       | Monkey      | `null`      | `null`      |
| **4**       | Spaghetti   | `null`      | `null`      |

---

a `FULL OUTER JOIN` with `WHERE` produces the set of records unique to either A or B

*QUERY:*

```sql
SELECT * FROM A
FULL OUTER JOIN B
ON A.name = B.name
WHERE A.id IS null;
OR B.id IS null;
```

*DATA:*

| A.id        | A.name      | B.id        | B.name      |
| ----------- | :---------: | ----------- | :---------: |
| **2**       | Monkey      | `null`      | `null`      |
| **4**       | Spaghetti   | `null`      | `null`      |
| `null`      | `null`      | **1**       | Rutabage    |
| `null`      | `null`      | **3**       | Darth Vader |

---

## Addition Notes on Specific JOIN Clauses

### INNER JOIN

the most basic type of `JOIN`

an `INNER JOIN` clause returns rows in `A` table that have corresponding rows in `B` table

let's say we have a table `A` with keys `key1` and `key2`, and a table `B` with keys `key3`, `key4`, and `key5` where `B.key5` corresponds to `A.key1`:

```sql
SELECT A.key1 A.key2, B.key3, B.key4
FROM A
INNER JOIN B ON A.key1 = B.key3;
```

`A` is the main table, and `B` is the tabled being joined to

specifying the table when selecting (`A.key`) is only mandatory if the `key` appears in both tables

`INNER` can be dropped; `JOIN` by itself will default to an `INNER JOIN`

### LEFT/RIGHT OUTER JOIN

the keyword `OUTER` can be dropped when the `LEFT` or `RIGHT` keyword is present
