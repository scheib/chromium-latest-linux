#! /bin/bash

cd $(dirname $0)

#COMPRUEBA QUE NO ESTÉ ACTUALIZANDO
if [ -e "State/UPDATING" ]; then
    notify-send -t 20000 -i "Icons/Chromium Update.png" "Updating Chromium..." "Chromium is currently being updated ..."
    exit 0
fi

LASTCHANGE_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2FLAST_CHANGE?alt=media"

REVISION=$(curl -s -S $LASTCHANGE_URL)

#echo "latest revision is $REVISION"

#COMPRUEBA SI ESTÁ ACTUALIZADO
if [ -d $REVISION ] ; then
#    echo "already have latest version"
    notify-send -t 8000 -i "Icons/Chromium Updated.png" "Updated (Rev.: $REVISION)" "Chromium is in its Latest Version"
  exit
fi

#CREA REGISTROS Y BLOQUEO
touch Update_Data/Version
touch Update_Data/Pre-Version
touch Update_Data/Pre-Pre-Version
touch Update_Data/Pre-Pre-Pre-Version
touch "$HOME/.Chromium/State/UPDATING"

ZIP_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F$REVISION%2Fchrome-linux.zip?alt=media"

ZIP_FILE="${REVISION}-chrome-linux.zip"

echo "fetching $ZIP_URL"

#rm -rf $REVISION
mkdir $REVISION
pushd $REVISION
curl -# $ZIP_URL > $ZIP_FILE
#echo "unzipping.."
unzip $ZIP_FILE
rm $ZIP_FILE
popd
#rm -rf ./latest/*
rm -f ./latest
ln -s $REVISION/chrome-linux/ ./latest

cat Update_Data/Pre-Pre-Version > Update_Data/Pre-Pre-Pre-Version
cat Update_Data/Pre-Version > Update_Data/Pre-Pre-Version
cat Update_Data/Version > Update_Data/Pre-Version
echo "$REVISION" > Update_Data/Version
OLD_VERSION=$(cat Update_Data/Pre-Pre-Pre-Version)
rm -rf "$OLD_VERSION"
notify-send -t 20000 -i "Icons/Chromium Updated.png" "Chromium Updated" "SChromium has been Successfully Updated. Chromium is in its Latest Version ($REVISION)"


rm UPDATING
if [ -e Status/REQUESTED ]; then
    ./run.sh
    rm Status/REQUESTED
fi
