#!/bin/bash

# Wait for Mysql to become available.
until nc -z -v -w30 dockstar-db 3306; do
  echo "Waiting for database connection..."
  sleep 5
done

# Update zone settings.
echo "Using ZoneIP: ${ZONE_IP}"
mysql dspdb -u ${DS_USERNAME} -p${DS_PASSWORD} -h dockstar-db -e "UPDATE zone_settings SET zoneip = '${ZONE_IP}'"

# Update GM lists.
echo "Current GMS: ${DS_GMS_LIST}"
IFS=',' read -ra gms <<< "${DS_GMS_LIST}"
for gm in "${gms[@]}"; do
    echo "Making $gm a level-5 game master."

    # Get character ID from name.
    id=`mysql dspdb -u ${DS_USERNAME} -p${DS_PASSWORD} -h dockstar-db -ss -e "SELECT charid FROM chars WHERE charname = '$gm'"`

    # Perform update.
    mysql dspdb -u ${DS_USERNAME} -p${DS_PASSWORD} -h dockstar-db -e "UPDATE chars SET gmlevel = 5 WHERE charid = $id"
done

# Start servers.
./dsconnect &
./dsgame &
./dssearch &

sleep infinity
