#! /bin/bash

cd $(dirname $0)

DEST_DIR=/opt/chromium
LASTCHANGE_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2FLAST_CHANGE?alt=media"

REVISION=$(curl -s -S $LASTCHANGE_URL)
echo "latest revision is $REVISION"

mkdir -p /tmp/$REVISION
pushd    /tmp/$REVISION

if [ grep $REVISION -nR $DEST_DIR 2>/dev/null ] ; then
  echo "Latest version is already installed."
  exit
fi

ZIP_FILE="${REVISION}-chrome-linux.zip"
if [ ! -f $ZIP_FILE ]; then
  ZIP_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F$REVISION%2Fchrome-linux.zip?alt=media"
  echo "fetching $ZIP_URL"
  curl -# $ZIP_URL > $ZIP_FILE
fi


echo "unzipping.."
unzip $ZIP_FILE
if [ -d $DEST_DIR ]; then
  sudo tar cvfz /tmp/chromium-$(date +%Y%m%d%H%M%S).tar.gz $DEST_DIR
  sudo rm -rf $DEST_DIR
fi
sudo mv chrome-linux $DEST_DIR

