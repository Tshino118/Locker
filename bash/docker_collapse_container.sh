#!/bin/bash -e

# Read repository configuration variables
. ./conf
# Read repository setting variables
. ./setting

echo "container name   : $container_name"

docker rm $container_name
