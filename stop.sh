#!/bin/bash

# Source default environment.
source src/scripts/env.sh

# Stop composer.
docker-compose -f src/docker-compose.yml down