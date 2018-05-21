# Change this value to match the IP address that your clients will use
# when connecting to the Darkstar server.
export ZONE_IP=${ZONE_IP:-$(dig +short myip.opendns.com @resolver1.opendns.com)}

# Username and password to use for the database.
export DS_USERNAME=${DS_USERNAME:-"darkstar"}
export DS_PASSWORD=${DS_PASSWORD:-"dockstar"}

# Name of the server.
export DS_SERVERNAME=${DS_SERVERNAME:-"Dockstar"}
