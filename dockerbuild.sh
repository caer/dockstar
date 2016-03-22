#!/bin/bash
# This file builds the altimit-server and altimit-db Docker images.

# Clean out any old containers. (Note: We keep the data container, if present)
docker stop altimit-server
docker rm altimit-server
docker stop altimit-db
docker rm altimit-db

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
docker build -f altimit-server.dockerfile -t altimit-server .
docker build -f altimit-db.dockerfile -t altimit-db .
docker build -f altimit-data.dockerfile -t altimit-data .
