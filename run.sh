#! /bin/bash

#if [ -e "$HOME/.Chromium/State/UPDATING" ]; then
#    notify-send -t 20000 -i "$HOME/.Chromium/Chromium Update.png" "Updating Chromium..." "Chromium is currently being updated. Please Wait... It Will Open When This Finalize."
#    touch "$HOME/.Chromium/State/REQUESTED"
#    exit 0
#else
    #REMOVE THE MESSAGE FROM GOOGLE APIs
    
        export GOOGLE_API_KEY="no"
        export GOOGLE_DEFAULT_CLIENT_ID="no"
        export GOOGLE_DEFAULT_CLIENT_SECRET="no"
    BASEDIR=$(dirname $0)
    
    $BASEDIR/latest/chrome --user-data-dir="$BASEDIR/user-data-dir" $* &> /dev/null &
#fi

case "$1" in
  linux)
    $BASEDIR/latest/chrome --user-data-dir="$BASEDIR/user-data-dir" $* &> /dev/null &
    ;;
  mac)
    open $BASEDIR/latest/chromium.app
    ;;
  *)
    echo "Please specify platform (mac or linux) as argument.";
    exit 1
    ;;
esac
