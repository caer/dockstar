#!/bin/bash

# Source default environment.
source src/scripts/env.sh

# Start composer.
docker-compose -f src/docker-compose.yml --project-directory . up
