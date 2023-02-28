#!/bin/bash -e
SCRIPT_DIR=$(cd $(dirname $0); pwd)

function ask_yes_no {
  while true; do
    echo -n "$* [y/n]: "
    read ANS
    case $ANS in
      [Yy])
        return 0
        ;;  
      [Nn])
        return 1
        ;;
      *)
        echo "Please type y or n."
        ;;
    esac
  done
}

if ask_yes_no "Could you remove previous container?:"; then
    echo "Removing container...: $container_name"
    bash $SCRIPT_DIR/remove_container.sh
else
    echo "Skip removing container."
fi
sleep 3s

echo "launch docker setup..."
# Read repository configuration variables
. ./conf
# Read repository setting variables
. ./setting
echo "repository name   : $repository_name"
echo "repository version: $repository_version"
echo "container name    : $container_name"

echo "Set up dependent images."
sh $SCRIPT_DIR/docker_setup.sh

echo "Create Docker image for Ros2."
sh $SCRIPT_DIR/repository_setup.sh

echo "Start container."
sh $SCRIPT_DIR/launch_container.sh

echo "Check container status."
docker ps

echo "done..."
