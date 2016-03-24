#!/bin/bash

# Load configuration.
source /config.sh

# Start MySQL.
mysqld --bind-address=0.0.0.0 &

# Wait for MySQL.
sleep 3

# Update zone settings.
echo "Using ZoneIP: ${ZONE_IP}"
mysql dspdb -u root -p -h 127.0.0.1 -e "UPDATE zone_settings SET zoneip = '${ZONE_IP}'"

sleep infinity
