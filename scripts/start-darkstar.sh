#!/bin/bash

# Copy configuration skeleton files to their correct locations.
cp -rf conf/login_darkstar.skel conf/login_darkstar.conf
cp -rf conf/map_darkstar.skel conf/map_darkstar.conf
cp -rf conf/search_server.skel conf/search_server.conf
cp -rf conf/server_message.skel conf/server_message.conf

# Process environment variables in the configuration files.
sed -i "s/DS_USERNAME/${DS_USERNAME}/g" conf/*.conf
sed -i "s/DS_PASSWORD/${DS_PASSWORD}/g" conf/*.conf
sed -i "s/DS_SERVERNAME/${DS_SERVERNAME}/g" conf/*.conf
cat conf/login_darkstar.conf
cat conf/map_darkstar.conf
cat conf/search_server.conf

# Wait for Mysql to become available.
until nc -z -v -w30 dockstar-db 3306; do
  sleep 5
done

# Update zone settings.
echo "Using ZoneIP: ${ZONE_IP}"
mysql dspdb -u ${DS_USERNAME} -p${DS_PASSWORD} -h dockstar-db -e "UPDATE zone_settings SET zoneip = '${ZONE_IP}'"

# Update GM lists.
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
