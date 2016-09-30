# Start Docker MySQL data container.
docker run --name dockstar-data dockstar-data

# Start Docker MySQL container for the darkstar DB.
docker run --name dockstar-db --net=host --volumes-from dockstar-data -dit dockstar-db

# Wait a brief moment to make absolute certain the DB is ready in time.
sleep 5

# Start Docker Dockstar container for the game server.
docker run --name dockstar-server --net=host -dit dockstar-server
