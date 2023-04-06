#!/bin/bash -e

# Read repository configuration variables
. ./conf
# Read repository setting variables
. ./setting

echo "==> Pulling $BASE_IMAGE now..."
docker pull $BASE_IMAGE
docker images
