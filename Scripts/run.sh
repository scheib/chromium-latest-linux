#! /bin/bash

BASEDIR=$(dirname $0)
KernelOS=$(uname)

if [ -e "State/UPDATING" ]; then
    if [ $KernelOS == "Linux" ]; then notify-send -t 20000 -i "$HOME/.Chromium/Chromium Update.png" "Updating Chromium..." "Chromium is currently being updated. Please Wait... It Will Open When This Finalize." ; fi
    if [ $KernelOS == "Darwin" ]; then osascript -e 'display notification "Chromium is currently being updated. Please Wait... It Will Open When This Finalize." with title "Updating Chromium..." sound name "Submarine"' ; fi
    touch "$HOME/.Chromium/State/REQUESTED"
    exit 0
else
        #REMOVE THE MESSAGE FROM GOOGLE APIs
        export GOOGLE_API_KEY="no"
        export GOOGLE_DEFAULT_CLIENT_ID="no"
        export GOOGLE_DEFAULT_CLIENT_SECRET="no"

fi

case "$KernelOS" in
  Linux)
    $BASEDIR/latest/chrome --user-data-dir="$BASEDIR/user-data-dir" $* >> /dev/null &
    ;;
  Darwin)
    open $BASEDIR/latest/chromium.app
    ;;
  *)
    echo "Error identifying the Operating System. Your current system is: $KernelOS and it is not specified in the functions of this script. Please, Contact to the developer on GitHub";
    read RESPONSE
    exit
    ;;
esac
