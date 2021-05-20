#!/bin/bash

cd $(dirname $0)
touch Update_Data/Last_AutoUpdate >> /dev/null
LAST_UPDATE=$(cat Update_Data/Last_AutoUpdate)
DATE=$(date +%j)

if [ "$LAST_UPDATE" = "$DATE" ]; then
    exit
else
    sleep 20
    bash ./update.sh
    echo "$DATE" > Update_Data/Last_AutoUpdate
fi
