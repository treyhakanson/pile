# NOTE: this is a basic overview of how to interact
# with PostGreSQL using the python library psycopg2;
# This file assumes knowledge of python.

# import psycopg
import psycopg2 as pg2

# establish a connection to the database;
# default user will be postgres unless otherwise
# specified
conn = pg2.connect(database='dvdrental', user='postgres', password='Zes2aw01_6v4DW0q1')

# retrieve a "cursor"
cur = conn.cursor()

# execute takes a raw query
cur.execute('SELECT * FROM payment')

# will retrieve the specified number of rows
# important to note that fetchmany returns
# results as tuples
data = cur.fetchmany(10)

# fetchone, fetchall are also options

# close connection when done
conn.close()

# NOTE: its best practice to not execute
# SQL queries of concatenated strings; all
# SQL queries should be written as 1 string
# and not built dynamically; this avoids doing
# something like accidentally adding "DROP TABLE"
# and destroying a database
