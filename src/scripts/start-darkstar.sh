#!/bin/bash

# Copy configuration skeleton files to their correct locations.
cp -rf conf/login_darkstar.drk conf/login_darkstar.conf
cp -rf conf/map_darkstar.drk conf/map_darkstar.conf
cp -rf conf/search_server.drk conf/search_server.conf
cp -rf conf/server_message.drk conf/server_message.conf

# Process environment variables in the configuration files.
sed -i "s/DRK_DB_HOST/${DRK_DB_HOST}/g" conf/*.conf
sed -i "s/DRK_DB_NAME/${DRK_DB_NAME}/g" conf/*.conf
sed -i "s/DRK_DB_USERNAME/${DRK_DB_USERNAME}/g" conf/*.conf
sed -i "s/DRK_DB_PASSWORD/${DRK_DB_PASSWORD}/g" conf/*.conf
sed -i "s/DRK_SERVERNAME/${DRK_SERVERNAME}/g" conf/*.conf

# Wait for Mysql to become available.
until nc -z -v -w30 ${DRK_DB_HOST} 3306; do
  echo "Database @${DRK_DB_HOST} not yet available. Sleeping..."
  sleep 10
done

# Update zone settings.
echo "Using Zone IP: ${DRK_ZONE_IP}"
mysql ${DRK_DB_NAME} -u ${DRK_DB_USERNAME} -p${DRK_DB_PASSWORD} -h ${DRK_DB_HOST} -e "UPDATE zone_settings SET zoneip = '${DRK_ZONE_IP}'"

# Update GM lists.
IFS=',' read -ra gms <<< "${DRK_GMS_LIST}"
for gm in "${gms[@]}"; do
    echo "Making $gm a level-5 game master."

    # Get character ID from name.
    id=`mysql ${DRK_DB_NAME} -u ${DRK_DB_USERNAME} -p${DRK_DB_PASSWORD} -h ${DRK_DB_HOST} -ss -e "SELECT charid FROM chars WHERE charname = '$gm'"`

    # Perform update.
    mysql ${DRK_DB_NAME} -u ${DRK_DB_USERNAME} -p${DRK_DB_PASSWORD} -h ${DRK_DB_HOST} -e "UPDATE chars SET gmlevel = 5 WHERE charid = $id"
done

# Start servers.
./dsconnect &
./dsgame &
./dssearch &

sleep infinity
