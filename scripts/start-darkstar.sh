#!/bin/bash

# Wait for Mysql to become available.
until nc -z -v -w30 dockstar-db 3306
do
  echo "Waiting for database connection..."
  sleep 5
done

# Update zone settings.
echo "Using ZoneIP: ${ZONE_IP}"
mysql dspdb -u ${DS_USERNAME} -p${DS_PASSWORD} -h dockstar-db -e "UPDATE zone_settings SET zoneip = '${ZONE_IP}'"

# Start servers.
./dsconnect &
./dsgame &
./dssearch &

sleep infinity
