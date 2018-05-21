#!/bin/bash

# Source configuration.
source config.sh

# Stop running instanced.
bash stop.sh

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

# Build composer.
docker-compose build