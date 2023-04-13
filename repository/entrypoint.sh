#!/bin/bash

USER_ID=${LOCAL_UID:-9001}
GROUP_ID=${LOCAL_GID:-9001}
USER_NAME=${LOCAL_USER:developer}
GROUP_NAME=${LOCAL_GROUP:developer}
HOME_DIR=${LOCAL_HOME}

echo "entrypoint.sh"
echo "Starting with UID : $USER_ID, GID: $GROUP_ID"
echo "USER_NAME: ${USER_NAME}"
echo "GROUP_NAME: ${GROUP_NAME}"
# adduser --uid ${USER_ID} --home ${HOME_DIR} ${USER_NAME} && chown -R ${USER_NAME} ${HOME_DIR}
sudo useradd -m $USER_NAME -u $USER_ID -s /bin/bash && sudo chown -R ${USER_NAME} ${HOME_DIR}
sudo passwd $USER_NAME

sudo usermod -G sudo $USER_NAME
sudo cat /etc/group | grep $USER_NAME
echo "id:" | id
