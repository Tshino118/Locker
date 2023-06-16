#!/bin/bash -e
SCRIPT_DIR=$(cd $(dirname $0); pwd)
# Read repository configuration variables
. ./conf
# Read repository setting variables
. ./setting

docker container restart $container_name