# Mongo DB Notes

## Overview
MongoDB is a document database, meaning that items are stored in a format similar to JSON objects.

Pros to Document DBs:
- documents correspond to native types in many languages
- embedded documents and arrays reduce the need for expensive joins
- Dynamic schema supports fluent polymorphism

MongoDB stores `BSON` documents, or data records, in collections, and collections in databses:
*Databases -> Collections -> BSON Documents*

### MongoDB Documents
MongoDB Documents are stored as `BSON`, which is a binary representation of `JSON`. `BSON` contains more datatypes than `JSON`, and the full `BSON` spec can be found [here](http://bsonspec.org/). A list of types and an explaination of what they represent can be found [here](https://docs.mongodb.com/manual/reference/bson-types/).

The value of any field can be any of the `BSON` data types. Documents can be embedded in other documents, and even array of documents are a possibility

Document name restrictions:
- `_id` is reserved for use as the primary key, which is unique, immutable, and may be of any type other than an array
- cannot start with `$`
- cannot contain `.`
- cannot contain the `null` character

MongoDB uses dot notation to access array indices (0 based):
`<array>.<index>`

### Collections
a collection is a grouping of MongoDB documents. It exists within a single database, and does not enforce a schema. Typically, all documents in a collection have similar or related purpose, but they can have varying fields.

a collection is the equivalent of an `RDBMS` (Relational Database Management System) table, which is found in relational (`SQL`) databases.

### Views
- read-only
- views use indices of the underlying collection
- views are considered sharded if their underlying collection is sharded. Therefore, you cannot specify a sharded view for the from field in `$lookup` and `$graphLookup` operations.
- views are computed on demand during read operations, and MongoDB executes read operations on views as part of the underlying aggregation pipeline. Therefore, views do not support such operations as:
    - `db.collection.mapReduce()`
    - `$text` pipeline stage
    - `geoNear` and `$geoNear` pipeline stage
- `$find` operations on views do not support the following projection operators:
    - $
    - $elemMatch
    - $slice
    - $meta
- If the aggregation pipeline used to create the view suppresses the _id field, documents in the view do not have the _id field.
- views cannot be renamed.
- String comparisons on the view use the view’s default collation. An operation that attempts to change or override a view’s default collation will fail with an error.
- You cannot specify a $natural sort on a view.

### Capped Collections
[link](https://docs.mongodb.com/manual/core/capped-collections/)

fixed size collections that overwrite their oldest entries once they reach a specified size limit. Work similarly to circular buffers.

create capped collections using `createCollection()` or `create` and specifying options:
`db.createCollection('<collection name>', { capped: true, size: 1000000 })`
if the `size` option is less than 4096, it will take up 4096 bytes. Otherwise, the size will be rounded up to the nearest multiple of 256. `max` can be used to specify the maximum number of _documents_ in addition to the maximum `size` in bytes (required, even if `max` is specified).

capped collections gaurantee preservation of insertion order; therefore queries do not need an index to return documents in insertion order. This allows for higher insertion throughput.

individual items cannot be deleted from a capped collection, but `drop()` can be used to clear the collection

---
## Setup
to install:
bash`brew install mongo`

by default, mongod will attempl to write to /data/db, so will need to create this directory with the following (or change the dbpath to another directory):
bash`mkdir -p /data/db`

to run the database at the default data path (/data/db):
bash`mongob`

to run at a different data path:
bash`mongod --dbpath <path/to/data>`

---
## Configuration
the `~/.mongorc.js` file will be evaluated on running the `mongo` shell. the `--norc` flag can be added when running the shell to prevent the rc from being executed. It is important to note that the rc will run _before_ a specified js file or statement using the `--eval` flag or similar method (`mongo file.js`).

---
## The Mongo Shell

### Overview
See more information [here](https://docs.mongodb.com/manual/reference/program/mongo/#mongo-usage-examples), or see the CLI reference [here](https://docs.mongodb.com/manual/reference/program/mongo/). The shell is a javascript interface so the logic and structure is as would be expected for javascript

### Connecting to a Remote Database
Long Form:
`mongo --username <user> --password <pass> --host <host> --port <port>`

Short Form:
`mongo -u <user> -p <pass> --host <host> --port <port>`

`--port` can be omitted as needed

### Shell Commands
The full list of shell commands can be found [here](https://docs.mongodb.com/manual/reference/method/). Tab can be used in the interface to autocomplete collection names, etc.

- `db`: displays the database being used
- `use <database>`: switches the current database being used
    - calling `use` with a database name that does not exist yet will create it
- `show dbs`: lists all current databases
- `db.getSiblings()`: access a different database from the current database without losing the current database context
- `db.<collection name>.insert({ <key>: <value> })` will insert a value into the collection `<collection name>`. If the collection does not yet exist it will be created
    - may need to use square braces or `getCollection` to call the collections name, if it is invalid (by normal js rules, so if it starts with a number, contains a space, or contains a hyphen)
- `db.<collection name>.find()` will found a collection and return a cursor. If not assigned to a variable using the `var` keyword, it will be iterated and printed upon up to 20 times.
    - adding `.pretty()` after `find` will make the output more readable
    - for more information on iterating over cursors or just cursors in general, see [here](https://docs.mongodb.com/manual/tutorial/iterate-a-cursor/)
- `print`, `print(tojson(<obj>))`, and `printjson` are all options to display results from the database
- `db.createCollection` explicitly creates a collection. Only necessary when additional options need to be specified on creation; othewise the collection will just be created on creating the first entry

---
## CRUD Operations

### Overview
MongoDB supports all the standard Create, Read, Update, and Delete operations.
Write operations in mongo are atomic on the level of a single document. All other operations target a single collection.

### Create Operations
[link](https://docs.mongodb.com/manual/reference/insert-methods/)

insert operations will add new documents to a collection, and will create a new collection if the one being written to does not exist. Certain update/find and modify operations will also write documents to the database (if they don't exist). At this point the operations will follow the some document-level [atomicity](https://docs.mongodb.com/manual/core/write-operations-atomicity/) as standard write operations.

- `db.<collection name>.insert()`
    - can be used to insert one document into a collection. Returns a `WriteResult` object that contains the number of documents inserted (`nInstered`) and error information (if present)
    - can also be used to insert many documents into a collection. Returns a `BulkWriteResult` object that contains various field sabout the insertion
- `db.<collection name>.insertOne()`
    - Inserts one document, and returns a document with the inserted document's id (`insertedId`)
- `db.<collection name>.insertMany()`
    - Inserts many documents into the database, and returns a document containing an array of the ids of each document inserted (an array called `insertedIds`)

MongoDB also supports bulk write operations

### Read Operations
read queries for and collects items from the database

- `db.<collection name>.find()`
- `db.<collection name>.findOne()`

structure:
```
db.<collection name>.find(
    {}, // query criteria
    {}  // projection
).limit(5);
```

this method can specify query filters or criteria that identify the documents to return

examples of queries and structures:
- Find all
    - `db.<collection name>.find()` 
    - `db.<collection name>.find({})` 
- Find based on document value
    - `db.<collection name>.find({ <field>: <value> })` 
- Specify conditions using query operators
    - `db.<collection name>.find({ <field>: { <operator1>: <value> } })` 
    - example: `db.inventory.find( { status: { $in: [ "A", "D" ] } } )` will find every item in the `inventory` collection with a `status` in the array specified by `$in` (so either `"A"` or `"D"`)
- Can combine values and query operators (logical `AND`)
    - example: `db.inventory.find({ status: "A", qty: { $lt: 30 } })` will get items from `inventory` with a `status` of `"A"` and a `qty` whose value is less than (`$lt`) `40`
- Can check for one or more matches (logical `OR`)
    - example: `db.inventory.find( { $or: [ { status: "A" }, { qty: { $lt: 30 } } ] })` will find items from `inventory` whose `status` is `"A"` or whose `qty` is less than (`$lt`) `30`
- Can even handle complex logic involving `AND` and `OR`
    - example, which will find items with a `status` of `"A"` and either a `qty` less than `30` or an `item` whose value starts with the letter `p`:
```
    db.inventory.find( {
        status: "A",
        $or: [ { qty: { $lt: 30 } }, { item: /^p/ } ]
    });
```
- also supports `$regex`

`find` returns a `cursor` object


### Update Operations
update operations modify existing documents in the mongo database

- `db.<collection name>.update()`
- `db.<collection name>.updateOne()`
- `db.<collection name>.updateMany()`
- `db.<collection name>.replaceOne()`

structure:
```
db.<collection name>.update(
    {}, // update criteria
    {}, // update action
    {}  // update option
);
```

### Delete Operations
delete operations remove documents from the database

`db.<collection name>.remove()`
`db.<collection name>.deleteOne()`
`db.<collection name>.deleteMany()`

structure:
```

```
