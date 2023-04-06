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
    bash $SCRIPT_DIR/docker_collapse_container.sh
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

echo -e "Set up dependent images.\n"
echo "# docker_pull_image.sh #########################################################"
sh $SCRIPT_DIR/docker_pull_image.sh
echo -e"######################################################### docker_pull_image.sh #\n"

echo "Create Docker image."
echo "# docker_build_image.sh #########################################################"
sh $SCRIPT_DIR/docker_build_image.sh
echo -e "######################################################### docker_build_image.sh #\n"

echo "Start container."
echo "# docker_run_container.sh #########################################################"
sh $SCRIPT_DIR/docker_run_container.sh
echo -e "######################################################### docker_run_container.sh #\n"

echo "Check container status."
docker ps

echo "done..."
