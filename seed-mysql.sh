#!/bin/bash
# This file should be executed from the darkstar/sql directory.

# Create darkstar user.
mysql -u root -p -h 127.0.0.1 -e "CREATE USER 'darkstar'@'%' IDENTIFIED BY 'a1t1m1t'"
mysql -u root -p -h 127.0.0.1 -e "CREATE DATABASE dspdb"
mysql -u root -p -h 127.0.0.1 -e "GRANT ALL PRIVILEGES ON dspdb.* TO 'darkstar'@'%'"

# Seed database with SQL files.
for f in *.sql
  do
    mysql dspdb -u darkstar -pa1t1m1t -h 127.0.0.1 < $f && echo "Success"
  done

# Update zone settings.
mysql dspdb -u root -p -h 127.0.0.1 -e "UPDATE zone_settings SET zoneip = '192.168.1.105'"
