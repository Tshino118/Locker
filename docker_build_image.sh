#!/bin/bash -e

# Read repository configuration variables
. ./conf
# Read repository setting variables
. ./setting

# Building Docker repository
echo -n "Root user password:" 
read ROOT_PASS

tty -s && echo
docker build -t $repository_name:$repository_version $REPOSITORY_DIR --build-arg BASE_IMAGE=$BASE_IMAGE --build-arg TIME_ZONE=$TIME_ZONE --build-arg ROOT_PASS=$ROOT_PASS --build-arg USER_NAME=$USER_NAME --build-arg HOME_DIR=$HOME_DIR
