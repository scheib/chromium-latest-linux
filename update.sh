#! /bin/bash

cd $(dirname $0)

#CHECK THAT IS NOT ALREDY UPDATING
if [ -e "State/UPDATING" ]; then
    if [ $1 == "mac" ]; then osascript -e 'display notification "Chromium is currently being updated ..." with title "Updating Chromium..." sound name "Submarine"' ; fi
    if [ $1 == "linux" ]; then notify-send -t 20000 -i "$(pwd)/Icons/Chromium Update.png" "Updating Chromium..." "Chromium is currently being updated ..." ; fi
    exit
fi

case "$1" in
  linux)
    PLATFORM="linux"
    REVISION_PREFIX="Linux_x64"
    ;;
  mac)
    PLATFORM="mac"
    REVISION_PREFIX="Mac"
    ;;
  *)
    echo "Please specify platform (mac or linux) as argument.";
    exit 1
    ;;
esac

#CHECK IF IT ISN'T UPDATED
if [ -e "State/UPDATING" ]; then
    if [ $1 == "linux" ]; then notify-send -t 20000 -i "$(pwd)/Icons/Chromium Update.png" "Updating Chromium..." "Chromium is currently being updated ..." ; fi
    if [ $1 == "mac" ]; then osascript -e 'display notification "Chromium is currently being updated ..." with title "Updating Chromium..." sound name "Submarine"' ; fi
    exit 0
fi

LASTCHANGE_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/${REVISION_PREFIX}%2FLAST_CHANGE?alt=media"

REVISION=$(curl -s -S $LASTCHANGE_URL)


#CHECK IF IT'S ALREDY UPDATED
if [ -d $REVISION ] ; then
    if [ $1 == "linux" ]; then notify-send -t 8000 -i "$(pwd)/Icons/Chromium Updated.png" "Updated (Rev.: $REVISION)" "Chromium is in its Latest Version" ; fi
    if [ $1 == "mac" ]; then osascript -e 'display notification "Chromium is in its Latest Version" with title "Updated (Rev.: $REVISION)" sound name "Submarine"' ; fi
  exit
fi

#CREATE LOGS Y LOCKS
touch Update_Data/Version
touch Update_Data/Pre-Version
touch Update_Data/Pre-Pre-Version
touch Update_Data/Pre-Pre-Pre-Version
touch State/UPDATING

ZIP_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/${REVISION_PREFIX}%2F${REVISION}%2Fchrome-${PLATFORM}.zip?alt=media"

ZIP_FILE="${REVISION}-chrome-${PLATFORM}.zip"

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

if [ $1 == "linux" ]; then notify-send -t 20000 -i "$(pwd)/Icons/Chromium Updated.png" "Chromium Updated" "Chromium has been Successfully Updated. Chromium is in its Latest Version ($REVISION)" ; fi
if [ $1 == "mac" ]; then ln -s ~/.chromium/latest/Chromium.app/ /Applications/Chromium.app && osascript -e 'display notification "Chromium has been Successfully Updated. Chromium is in its Latest Version ($REVISION)" with title "Chromium Updated" sound name "Submarine"' ; fi

rm UPDATING
if [ -e Status/REQUESTED ]; then
    ./run.sh
    rm Status/REQUESTED
fi
