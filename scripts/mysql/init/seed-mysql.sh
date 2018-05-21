#!/bin/bash

# Create darkstar user.
# mysql -u root -p${MYSQL_ROOT_PASSSWORD} -h localhost -e "CREATE USER '${DS_USERNAME}'@'%' IDENTIFIED BY '${DS_PASSWORD}'"
# mysql -u root -p${MYSQL_ROOT_PASSSWORD} -h localhost -e "CREATE DATABASE dspdb"
# mysql -u root -p${MYSQL_ROOT_PASSSWORD} -h localhost -e "GRANT ALL PRIVILEGES ON dspdb.* TO '${DS_USERNAME}'@'%'"

# Seed database with SQL files.
for f in /tmp/darkstar/sql/*.sql
  do
    echo -n "Importing $f into the database..."
    mysql dspdb -u ${DS_USERNAME} -p${DS_PASSWORD} -h localhost < $f && echo "Success"
  done
