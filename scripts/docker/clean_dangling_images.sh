#!/bin/bash

echo "Attempting to clean all images tagged '<none>'. Deletion of some images might fail .. "
docker images -q --filter "dangling=true"  | xargs --no-run-if-empty docker rmi
