# Add your character name to this list in order to have them become a level 5 GM.
# Example: DS_GMS_LIST=${DS_GMS_LIST-(crahda jane john)}
export DS_GMS_LIST=${DS_GMS_LIST-()}

# Change this value to match the IP address that your clients will use
# when connecting to the Darkstar server.
export ZONE_IP=${ZONE_IP:-$(dig +short myip.opendns.com @resolver1.opendns.com)}

# Username and password to use for the database.
export DS_USERNAME=${DS_USERNAME:-"darkstar"}
export DS_PASSWORD=${DS_PASSWORD:-"dockstar"}

# Name of the server.
export DS_SERVERNAME=${DS_SERVERNAME:-"Dockstar"}
