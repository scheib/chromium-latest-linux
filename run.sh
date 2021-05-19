#! /bin/bash

#if [ -e "$HOME/.Chromium/State" ]; then
#    notify-send -t 20000 -i "$HOME/.Chromium/Chromium Update.png" "Updating Chromium..." "Chromium is currently being updated. Please Wait... It Will Open When This Finalize."
#    touch "$HOME/.Chromium/State/Requested"
#    exit 0
#else
    #REMOVE THE MESSAGE FROM GOOGLE APIs
        export GOOGLE_API_KEY="no"
        export GOOGLE_DEFAULT_CLIENT_ID="no"
        export GOOGLE_DEFAULT_CLIENT_SECRET="no"
    BASEDIR=$(dirname $0)
    $BASEDIR/latest/chrome --user-data-dir="$BASEDIR/user-data-dir" $* &> /dev/null &
#fi
