#!/bin/bash -e

# Read repository configuration variables
. ./conf
# Read repository setting variables
. ./setting

echo "==> Pulling $base_image now..."
docker pull $base_image
docker images
