#!/bin/bash

# Seed database with SQL files.
# Environment variables should already be 
# set appropriately by the container engine.
for f in /tmp/darkstar/sql/*.sql
  do
    echo "Importing $f into the database..."
    mysql ${MYSQL_DATABASE} -u ${MYSQL_USER} -p${MYSQL_PASSWORD} -h localhost < $f && echo "Success!"
  done
