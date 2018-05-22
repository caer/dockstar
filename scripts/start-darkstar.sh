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

# Update GM lists.
for gm in "${DS_GMS_LIST[@]}" 
do
    echo "Making $gm a level-5 game master."
    mysql dspdb -u ${DS_USERNAME} -p${DS_PASSWORD} -h dockstar-db -e "UPDATE chars SET gmlevel = 5 WHERE charid = (SELECT charid FROM chars WHERE charname = '$gm')"
done

# Start servers.
./dsconnect &
./dsgame &
./dssearch &

sleep infinity
