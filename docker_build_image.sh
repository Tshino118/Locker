#!/bin/bash -e

# Read repository configuration variables
. ./conf
# Read repository setting variables
. ./setting

# Building Docker repository
docker build -t $repository_name:$repository_version $REPOSITORY_DIR --build-arg BASE_IMAGE=$BASE_IMAGE --build-arg TIME_ZONE=$TIME_ZONE --build-arg USER_NAME=$USER_NAME --build-arg HOME_DIR=$HOME_DIR
