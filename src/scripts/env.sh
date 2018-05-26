# Add your character name to this list in order to have them become a level 5 GM.
# Example: DS_GMS_LIST=${DS_GMS_LIST:-"Crahda,Chris,John"}
export DRK_GMS_LIST=${DRK_GMS_LIST:-""}

# Change this value to match the IP address that your clients will use
# when connecting to the Darkstar server. Defaults to the public IP of the server.
export DRK_ZONE_IP=${DRK_ZONE_IP:-$(dig +short myip.opendns.com @resolver1.opendns.com)}

# Host of the database. When using the containers, this
# does not need to be modified.
export DRK_DB_HOST=${DRK_DB_HOST:-"dockstar-db"}

# Name of the database.
export DRK_DB_NAME=${DRK_DB_NAME:-"dspdb"}

# Username and password to use for the database.
# These must not be changed after the server is built.
export DRK_DB_USERNAME=${DRK_DB_USERNAME:-"darkstar"}
export DRK_DB_PASSWORD=${DRK_DB_PASSWORD:-"dockstar"}

# Name of the server.
export DRK_SERVERNAME=${DRK_SERVERNAME:-"Dockstar"}
