#!/bin/bash

# Source default environment.
source scripts/env.sh

# Stop running instanced.
bash stop.sh &> /dev/null

# Clone repo and checkout stable.
if [ -d "darkstar" ]; then
    echo "Using existing Darkstar repository."
else
    echo "Cloning new Darkstar repository and using MASTER branch (STABLE lags behind too far)."
    git clone http://github.com/DarkstarProject/darkstar.git/
fi

# Build server image.
docker build -f dockerfiles/dockstar-server.dockerfile -t dockstar-server .