#!/bin/bash

# Process config files.
sed -i "s/DS_USERNAME/${DS_USERNAME}/g" *.conf
sed -i "s/DS_PASSWORD/${DS_PASSWORD}/g" *.conf
sed -i "s/DS_SERVERNAME/${DS_SERVERNAME}/g" *.conf
