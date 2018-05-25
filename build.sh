#!/bin/bash

# Source configuration.
source scripts/config.sh

# Stop running instanced.
bash stop.sh

# Clone repo and checkout stable.
if [ -d "darkstar" ]; then
    echo "Using existing Darkstar repository."
else
    echo "Cloning new Darkstar repository and using MASTER branch (STABLE lags behind too far)."
    git clone http://github.com/DarkstarProject/darkstar.git/
fi

# Build composer.
docker-compose build