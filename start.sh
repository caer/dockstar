# Start Docker MySQL data container.
docker run --name altimit-data altimit-data

# Start Docker MySQL container for the darkstar DB.
docker run --name altimit-db --net=host --volumes-from altimit-data -dit altimit-db

# Wait a brief moment to make absolute certain the DB is ready in time.
sleep 5

# Start Docker Altimit container for the game server.
docker run --name altimit-server --net=host -dit altimit-server
