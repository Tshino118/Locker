#!/bin/bash

USER_ID=${LOCAL_UID:-9001}
GROUP_ID=${LOCAL_GID:-9001}
USER_NAME=${LOCAL_USER:locker}
GROUP_NAME=${LOCAL_GROUP:locker}

echo "Starting with UID : $USER_ID, GID: $GROUP_ID"

sudo groupmod -g $GROUP_ID $GROUP_NAME
sudo usermod -u $USER_ID $USER_NAME
# sudo usermod -G sudo $USER_NAME
# sudo find / -user 9999 -exec chown -h $USER_NAME {} \;
# sudo find / -group 9999 -exec chgrp -h $GROUP_NAME {} \;

id $USER_NAME
