#!/bin/bash

USER_ID=${LOCAL_UID:-9001}
GROUP_ID=${LOCAL_GID:-9001}
USER_NAME=${LOCAL_USER:developer}
GROUP_NAME=${LOCAL_GROUP:developer}
HOME_DIR=${LOCAL_HOME}

echo "Setting password of root"
passwd root

echo "Starting with UID : $USER_ID, GID: $GROUP_ID"
echo "USER_NAME: ${USER_NAME}"
echo "GROUP_NAME: ${GROUP_NAME}"
# adduser --uid ${USER_ID} --home ${HOME_DIR} ${USER_NAME} && chown -R ${USER_NAME} ${HOME_DIR}
useradd -m $USER_NAME -u $USER_ID -s /bin/bash && chown -R ${USER_NAME} ${HOME_DIR}
passwd $USER_NAME

echo "username: ${USER_NAME}"

exec /usr/sbin/gosu $USER_NAME

