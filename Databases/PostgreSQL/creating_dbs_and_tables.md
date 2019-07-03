# Creating Databases and Tables

These notes pertain to creating databases and tables and manipulating the data inside of them. This information pertains mainly to _wiriting_ to databases and tables, so if you're only concerned with _reading_ from dbs/tables, check out some of the other notes.

## Data Types

PostGreSQL supports the following data types:

- Boolean
- Character
- Number
- Temporal
- Special Types
- Array

data type must be specified when creating a column for a table; this prevents the wrong type of data from being inserted into a column

### Boolean

A standard boolean (true/false) value

PostGreSQL will take the input and convert it to a boolean value:

- 1, yes, y, t, true -> `true`
- 0, no, n, f, false -> `false`

When selecting from a boolean column, PostGreSQL will display `t` for `true`, `f` for `false`, and a space character for `NULL`

### Character

3 types of character fields:

- `char` - single chracter.
- `char(n)` - fixed length string; if a string shorter than the specified length is inserted, spaces will be added as padding. If attempting to insert a longer string, PostGreSQL will issue an error.
- `varchar(n)` - variable length string. Allows for storage of a string up to `n` characters. PostGreSQL will **not** pad spaces for variable length string fields.

### Number

2 distinct types of number, each with sub-types:

- Integers
    - `smallint` - 2 byte, signed integer (-32768, 32767)
    - `int` - 4-byte, signed integer (-214783648, 214783647)
    - `serial` - same as `int`, but PostGreSQL will automatically populate the value (similar to `AUTO_INCREMENT` in db management systems)
- Floating point numbers
    - `float(n)` - a floating point number whose percision is up to at least n bytes, up to 8 bytes.
    - `real` or `float8` - a double precision (8 byte) floating point number
    - `numeric` or `numeric(p,s)` - is a real number with p digits and s numbers after the decimal point. `numeric(p,)` will give as much precision as possible (the extact number)

### Temporal

store data related to date and time:

- `date` stores date
- `time` stores time
- `timestamp` stores date and time
- `interval` stores the difference between timestamps
- `timestamptz` stores timestamp and timezone data

## Primary and Foreign Keys

### Primary Keys

a primary key is a column or group of columns used to identify a row uniquely to a table

they are defined through primary key constraints

a table can have only 1 primary key, and it's good practice to add a primary key to every table

primary keys are typically added on creating a table:

```sql
-- Create queries like this one are discussed more below
-- `PRIMARY KEY` here is a constraint

CREATE TABLE <table> (<col_name> <data_type> PRIMARY KEY, ...);
```

### Foreign Keys

A foreign key is a col or group of cols that uniquely identifies a row in _another_ table

in other words, a foreign key defined in one table represents the primary key of another table

the table containing the foreign key is the `referencing` or `child` table, and the table containing the primary key is the `referenced` or `parent` table

foreign keys are set using foreign key constraints

a foreign key maintains "referential integrity" between parent and child tables

## CREATE Table

basic syntax of the create clause:

```sql
CREATE TABLE <table>
(<col> TYPE <col_constraint>, <table_constraint>)
INHERITS <exisiting_table>;
```

examples of column constraints:

- `NOT NULL` the value of the column cannot be null
- `UNIQUE` the value of the column must be unique
    - can have many `NULL` columns though, because PostGreSQL treats each `NULL` value as unique
        - Standard SQL allows only 1 `NULL`
- `PRIMARY KEY` a combination of the `UNIQUE` and `NOT NULL` constraints
- `CHECK` allows for a check condition to be run on upload
- `REFERENCES` constrains the value of the column that exists in a column in another table
    - used to define foreign keys

table constraints

- `UNIQUE (<col_list>)` forces the value stored in the listed columns to be unique
- `PRIMARY KEY (<col_list>)` define a multi-column primary key
- `CHECK (condition)` condition to check on uploading to the table
- `REFERENCES` to constrain the value stored in the column that must exist in a column in another table

can aslo quickly create copies of tables (same schemas) using the following:

```sql
CREATE TABLE <copy>(LIKE <original>);
```

## Data Insertion

basic syntax of the `INSERT` statement

```sql
-- insert single row
INSERT INTO <table>(<col_1>, <col_2>, ...)
VALUES (<val_1>, <value_2>);

-- insert multiple rows
INSERT INTO <table>(<col_1>, <col_2>, ...)
VALUES (<val_1>, <value_2>),
       (<val_1>, <value_2>),
       ...;
```

can also use `INSERT` to copy data from another table:

```sql
INSERT INTO <table>
SELECT <col_1>, <col_2>
FROM <another_table>
WHERE <condition>;
```

important to note that something like an id will also be copied over, even if the table being copied too specifies it as a serial data type

## Update Values

`UPDATE` changes values in exisiting rows in a database. basic syntax:

```sql
UPDATE <table>
SET <col_1> = <val_1>,
    <col_2> = <val_2>,
    ...
WHERE <condition>;
```

Can also set a column equal to another column in the same table:

```sql
UPDATE <table>
SET <col_1> = <col_2>;
```

`RETURNING` keyward can be used to return specific columns of the result after an update:

```sql
UPDATE <table>
SET <col_1> = <val_1>
RETURNING <col_1>, <col_2>, ...; 
```

uploading from a csv is also possible:

```sql
COPY <table_to_copy_to> FROM '<file_path>' CSV HEADER;
```

## Deleting Rows

self-explanatory, syntax is as follows:

```sql
DELETE FROM <table>
WHERE <condition>;
```

the `DELETE` statement returns the number of rows deleted, and returns 0 if no rows are deleted. Can use `RETURNING` to return the rows that were deleted

## Alter Table

`ALTER TABLE` is used to change the format (schmea) of an exisiting table. The basic syntax is as follows:

`ALTER TABLE <table> <action>`

action statements in PostGreSQL:

- `ADD COLUMN`
- `DROP COLUMN`
- `RENAME COLUMN`
- `ADD CONSTRAINT`
- `RENAME TO`

using the above actions are relatively simple:

```sql
-- adding a column
ALTER TABLE <table> ADD COLUMN <col_name> <data_type>;

-- dropping a column
ALTER TABLE <table> DROP COLUMN <col_name>;

-- renaming a column
ALTER TABLE <table> RENAME COLUMN <col_name> TO <new_col_name>;

-- renaming the table
ALTER TABLE <table> RENAME TO <new_name>;
```

## Dropping Tables

dropping a table is the same thing as deleting it; basic syntax is:

```sql
DROP TABLE IF EXISTS <table>;
```

the `IF EXISTS` statement prevents the code trying to drop a table that doesn't exist, which throws an exception

`RESTRICT` can optionally be added to the end of the drop table statement to prevent the table from being dropped if another table depends on it

`CASCADE` can optionally be added to the end of the drop table statement to drop all other tables/views that are dependent on it

## Check Constraint

The `CHECK` constraint uses a boolean statement to determine whether or not data should be updated

`CHECK` can be applied as a column constraint during table creation (`CREATE TABLE`), or when adding a constraint (`ALTER TABLE ... ADD CONSTRAINT`):

```sql
...
<col_name> <data_type> CHECK(<boolean_expression>),
...;
```

PostGreSQL will throw an error if a check is not passed. In addition, PostGreSQL will automatically name the constraint as follows so it's easy to determine the issue: `<table_name>_<col_name>_check`

PostGreSQL uses similar syntax as the above for a lot of errors and such, so this is important to note.

It is also possible to pass a custom name to constraints:

```sql
<col_name> <data_type> 
CONSTRAINT <constraint_name>
CHECK(<boolean_expression>)
```

## The "Not Null" Constraint

`NULL` in PostGreSQL is different from something like "empty" or 0

All this constraint does is not allow for null values to be inserted into the column

if a value is 
