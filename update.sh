#! /bin/bash

cd $(dirname $0)

case "$1" in
  mac)
    PLATFORM="mac"
    REVISION_PREFIX="Mac"
    ;;
  linux | *)
    PLATFORM="linux"
    REVISION_PREFIX="Linux_x64"
    ;;
esac

LASTCHANGE_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/${REVISION_PREFIX}%2FLAST_CHANGE?alt=media"

REVISION=$(curl -s -S $LASTCHANGE_URL)

echo "latest revision is $REVISION"

if [ -d $REVISION ] ; then
  echo "already have latest version"
  exit
fi

ZIP_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/${REVISION_PREFIX}%2F${REVISION}%2Fchrome-${PLATFORM}.zip?alt=media"

ZIP_FILE="${REVISION}-chrome-${PLATFORM}.zip"

echo "fetching $ZIP_URL"

rm -rf $REVISION
mkdir $REVISION
pushd $REVISION
curl -# $ZIP_URL > $ZIP_FILE
echo "unzipping.."
unzip $ZIP_FILE
popd
rm -f ./latest
ln -s $REVISION/chrome-$PLATFORM/ ./latest

