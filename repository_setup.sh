#!/bin/bash -e

# Read repository configuration variables
. ./conf
# Read repository setting variables
. ./setting

# Building Docker repository
docker build -t $repository_name:$repository_version $REPOSITORY_DIR
