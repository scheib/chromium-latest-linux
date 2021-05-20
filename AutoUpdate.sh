#!/bin/bash

cd $(dirname $0)
LAST_UPDATE=$(cat Ultima_Actualizacion)
DATE=$(date +%j)

if [ "$LAST_UPDATE" = "$DATE" ]; then
    exit
else
    sleep 20
    bash ./update.sh
    echo "$DATE" > Ultima_Actualizacion
fi
