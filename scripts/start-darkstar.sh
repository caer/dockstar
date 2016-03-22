#!/bin/bash
./dsconnect &
echo "Started DSCONNECT."
./dsgame &
echo "Started DSGAME."
./dssearch &
echo "Started DSSEARCH."

sleep infinity
