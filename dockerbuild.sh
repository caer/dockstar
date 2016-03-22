#!/bin/bash
# This file builds the altimit-server and altimit-db Docker images.

# Clean out any old containers. (Note: We keep the data container, if present)
docker stop altimit-server &> /dev/null
docker rm altimit-server &> /dev/null
docker stop altimit-db &> /dev/null
docker rm altimit-db &> /dev/null

# Clone repo and checkout stable.
if [ -d "darkstar" ]; then
    cd darkstar
    git checkout stable
    git pull
    cd ..
else
    git clone http://github.com/DarkstarProject/darkstar.git/
    cd darkstar
    git checkout stable
    cd ..
fi

# Kick off builds.
docker build -f altimit-server.dockerfile -t altimit-server --no-cache .
docker build -f altimit-db.dockerfile -t altimit-db --no-cache .
docker build -f altimit-data.dockerfile -t altimit-data --no-cache .
