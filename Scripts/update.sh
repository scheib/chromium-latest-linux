#! /bin/bash

cd $(dirname $0)
KernelOS=$(uname)

#CHECK THAT IS NOT ALREDY UPDATING
if [ -e "State/UPDATING" ]; then
    if [ $KernelOS == "Darwin" ]; then osascript -e 'display notification "Chromium is currently being updated ..." with title "Updating Chromium..." sound name "Submarine"' ; fi
    if [ $KernelOS == "Linux" ]; then notify-send -t 20000 -i "$(pwd)/Icons/Chromium Update.png" "Updating Chromium..." "Chromium is currently being updated ..." ; fi
    exit
fi

case $KernelOS in
  Linux)
    PLATFORM="linux"
    REVISION_PREFIX="Linux_x64"
    ;;
  Darwin)
    PLATFORM="mac"
    REVISION_PREFIX="Mac"
    ;;
  *)
    echo "Error identifying the Operating System. Your current system is: $KernelOS and it is not specified in the functions of this script. Please, Contact to the developer on GitHub";
    read RESPONSE
    exit
    ;;
esac

#CHECK IF IT ISN'T UPDATED
if [ -e "State/UPDATING" ]; then
    if [ $KernelOS == "Linux" ]; then notify-send -t 20000 -i "$(pwd)/Icons/Chromium Update.png" "Updating Chromium..." "Chromium is currently being updated ..." ; fi
    if [ $KernelOS == "Darwin" ]; then osascript -e 'display notification "Chromium is currently being updated ..." with title "Updating Chromium..." sound name "Submarine"' ; fi
    exit 0
fi

LASTCHANGE_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/${REVISION_PREFIX}%2FLAST_CHANGE?alt=media"

REVISION=$(curl -s -S $LASTCHANGE_URL)


#CHECK IF IT'S ALREDY UPDATED
if [ -d $REVISION ] ; then
    if [ $KernelOS == "Linux" ]; then notify-send -t 8000 -i "$(pwd)/Icons/Chromium Updated.png" "Updated (Rev.: $REVISION)" "Chromium is in its Latest Version" ; fi
    if [ $KernelOS == "Darwin" ]; then osascript -e 'display notification "Chromium is in its Latest Version" with title "Updated" sound name "Submarine"' ; fi
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
ln -s $REVISION/chrome-$PLATFORM/ ./latest

cat Update_Data/Pre-Pre-Version > Update_Data/Pre-Pre-Pre-Version
cat Update_Data/Pre-Version > Update_Data/Pre-Pre-Version
cat Update_Data/Version > Update_Data/Pre-Version
echo "$REVISION" > Update_Data/Version
OLD_VERSION=$(cat Update_Data/Pre-Pre-Pre-Version)
rm -rf "$OLD_VERSION"

if [ $KernelOS == "Linux" ]; then notify-send -t 20000 -i "$(pwd)/Icons/Chromium Updated.png" "Chromium Updated" "Chromium has been Successfully Updated. Chromium is in its Latest Version ($REVISION)" ; fi
if [ $KernelOS == "Darwin" ]; then osascript -e 'display notification "Chromium has been Successfully Updated. Chromium is in its Latest Version " with title "Chromium Updated" sound name "Submarine"' ; fi

rm State/UPDATING
if [ -e Status/REQUESTED ]; then
    ./run.sh
    rm State/REQUESTED
fi
