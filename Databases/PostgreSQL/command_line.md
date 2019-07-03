# Postgres From the Command Line

## Installation

easiest to install via [brew](http://brew.sh):
```sh
brew install postgressql
```

postgres is now a service that can be controlled via brew:
```sh
# list all services
brew services list

# start service
brew service start <service_name>

# restart a service
brew service restart <service_name>
```

to create a postgres user, use:
```sh
createuser <user_name>
```

this command has various options:
- `-D` this user can create databases
- `-P` this user requires a password

from here, to create a database with this user:
```sh
# Create the database
createdb -O <database_owner> <database_name>
```

after that, can enter the postgres command line inteface with the new db using:
```sh
psql -D <database_name> -U <user>
```
