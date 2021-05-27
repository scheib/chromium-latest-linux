#!/bin/bash
BASEDIR=$(dirname $0)
KernelOS=$(uname)

#CREATE THE CHROMIUM FOLDER IN THE HOME DIRECTORY AND PUT AL THE THINGS IN THERE
mkdir ~/.chromium/

cp $BASEDIR/Scripts/Remove\ Last\ Version.sh ~/.chromium/
cp $BASEDIR/Scripts/run.sh ~/.chromium/
cp $BASEDIR/Scripts/update.sh ~/.chromium/

cp -r $BASEDIR/Icons ~/.chromium/

mkdir ~/.chromium/State
mkdir ~/.chromium/Update_Data

if [ $KernelOS == "Darwin" ]; then 
  clear
  echo "Please add '* * * * 1 /Users/$(whoami)/.chromium/AutoUpdate.sh' Then press control+'o' and Enter and control+'x' without the double quotes. And now you can close the terminal. Press Enter"
  echo ""
  read PAUSE
  echo "Are you ready? Did you copy the line with Ctrl+'C'?"
  echo ""
  read PAUSE
  export VISUAL=nano && sudo crontab -e
fi

if [ $KernelOS == "Linux" ]; then 
  sudo cat "/var/spool/cron/crontabs/$(whoami)" > /tmp/cronchromium 
  sudo echo "* * * * 1 $HOME/.chromium/AutoUpdate.sh" >> /tmp/cronchromium
  sudo cp -r /tmp/cronchromium "/var/spool/cron/crontabs/$(whoami)"
  sudo rm -r /tmp/cronchromium
  sudo cp $BASEDIR/Scripts/Aplication "/usr/bin/chromium"
  fi

clear
echo "Downloading..."
echo ""

bash ~/.chromium/update.sh
clear
bash ~/.chromium/run.sh &
exit
