#!/bin/sh

BASEDIR="$(dirname $(realpath $(readlink -f $0)))"

web() {
local list="wget curl"
for item in $list;
do
    if [ -z $(command -v $item) ]; then
        echo $list | sed "s/$item//g"
    fi
done
}

dl() {
case $(web) in
    *wget*) wget -q --show-progress -O $@;;
    *curl*) curl -#L -o $@;;
esac
}

out() {
case $(web) in
    *curl*) curl -sL $@;;
    *wget*) wget -qO - $@;;
esac
}

TRUNK="snapshots"
if [ -n "$1" ]; then
OPT="$1"
shift
case "$OPT" in
    snapshots|s) TRUNK="snapshots";;
    continuous|c) TRUNK="continuous";;
esac
fi

LASTCHANGE_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-$TRUNK/o/Linux_x64%2FLAST_CHANGE?alt=media"

REVISION=$(out $LASTCHANGE_URL)

echo "latest revision is $REVISION"

if [ -d $BASEDIR/$REVISION ] ; then
  echo "already have latest version"
  exit
fi

ZIP_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-$TRUNK/o/Linux_x64%2F$REVISION%2Fchrome-linux.zip?alt=media"

ZIP_FILE="chrome-linux-${REVISION}.zip"

echo "fetching $ZIP_URL"

dl "$BASEDIR/$ZIP_FILE" "$ZIP_URL"
echo "unzipping.."
unzip "$BASEDIR/$ZIP_FILE" -d "$BASEDIR"
mv "$BASEDIR/chrome-linux" "$BASEDIR/$REVISION"
rm -f "$BASEDIR/latest" "$BASEDIR/$ZIP_FILE"
ln -s "$BASEDIR/$REVISION" "$BASEDIR/latest"
