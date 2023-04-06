#!/bin/bash

USER_ID=${LOCAL_UID:-9001}
USER_NAME=user
GROUP_ID=${LOCAL_GID:-9001}
HOME=/home/$USER_NAME

echo "Starting with UID : $USER_ID, GID: $GROUP_ID"
adduser --uid $USER_ID --home $HOME $USER_NAME && chown -R $USER_NAME $HOME
groupmod -g $GROUP_ID $USER_NAME

export $HOME

#exec /usr/sbin/gosu $USER_NAME "$@"