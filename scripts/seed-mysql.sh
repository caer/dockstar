#!/bin/bash
# This file should be executed from the darkstar/sql directory.

# Load configurations.
source /tmp/darkstar/sql/config.sh

# Create darkstar user.
mysql -u root -p -h 127.0.0.1 -e "CREATE USER '${DS_USERNAME}'@'%' IDENTIFIED BY '${DS_PASSWORD}'"
mysql -u root -p -h 127.0.0.1 -e "CREATE DATABASE dspdb"
mysql -u root -p -h 127.0.0.1 -e "GRANT ALL PRIVILEGES ON dspdb.* TO '${DS_USERNAME}'@'%'"

# Seed database with SQL files.
for f in *.sql
  do
    echo -n "Importing $f into the database..."
    mysql dspdb -u ${DS_USERNAME} -p${DS_PASSWORD} -h 127.0.0.1 < $f && echo "Success"
  done
