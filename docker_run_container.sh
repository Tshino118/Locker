#!/bin/bash -e

# Read repository configuration variables
. ./conf
# Read repository setting variables
. ./setting

# Launch repository
docker run $container_run_args -it --gpus all --name $container_name $repository_name:$repository_version 
