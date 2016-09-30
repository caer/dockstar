#!/bin/bash
# This file generates all of the Docker images for the Darkstar server.

# Clean out any old containers. (Note: We keep the data container, if present)
docker stop dockstar-server &> /dev/null
docker rm dockstar-server &> /dev/null
docker stop dockstar-db &> /dev/null
docker rm dockstar-db &> /dev/null

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
docker build -f dockerfiles/dockstar-server.dockerfile -t dockstar-server .
docker build -f dockerfiles/dockstar-db.dockerfile -t dockstar-db .
docker build -f dockerfiles/dockstar-data.dockerfile -t dockstar-data .
