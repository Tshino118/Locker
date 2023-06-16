#!/bin/bash -e
. ./setting
. ./config
. ./utils
SCRIPT_DIR=$(cd $(dirname $0); pwd)

echo "Type repository_version:"
read -i'latest' -e repository_version
docker commit $container_name $repository_name:$repository_version
