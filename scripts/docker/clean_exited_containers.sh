#!/bin/bash

echo "Cleaning exited containers... "
docker ps -a -q -f status=exited | xargs --no-run-if-empty docker rm -v
