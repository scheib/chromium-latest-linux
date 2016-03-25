#! /bin/bash

cd $(dirname $0)

LASTCHANGE_URL="http://commondatastorage.googleapis.com/chromium-browser-continuous/Linux_x64/LAST_CHANGE"

REVISION=$(curl -s -S $LASTCHANGE_URL)

echo "latest revision is $REVISION"

if [ -d $REVISION ] ; then
  echo "already have latest version"
  exit
fi

ZIP_URL="http://commondatastorage.googleapis.com/chromium-browser-continuous/Linux_x64/$REVISION/chrome-linux.zip"

ZIP_FILE="${REVISION}-chrome-linux.zip"

echo "fetching $ZIP_URL"

rm -rf $REVISION
mkdir $REVISION
pushd $REVISION
curl -# $ZIP_URL > $ZIP_FILE
echo "unzipping.."
unzip $ZIP_FILE
popd
rm -f ./latest
ln -s $REVISION/chrome-linux/ ./latest

