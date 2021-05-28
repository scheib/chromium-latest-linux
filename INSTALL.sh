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

clear
echo "Downloading..."
echo ""
bash ~/.chromium/update.sh >> /dev/null
clear

if [ $KernelOS == "Darwin" ]; then 
  ln -s ~/.chromium/latest/Chromium.app/ /Applications/Chromium.app 
  while [ "$(crontab -l | grep "* * * * 1 $HOME/.chromium/AutoUpdate.sh")" = "* * * * 1 $HOME/.chromium/AutoUpdate.sh" ] || [ "$AUTO" != "s" ] || [ "$AUTO" != "S" ]; do
    clear
    echo ""
    echo "  If you don't want to have autoupdates, press 's' and Enter. Otherwise, press Enter"
    echo ""
    read AUTO
    if [  "$AUTO" = "s" ] || [ "$AUTO" = "S" ]; then bash ~/.chromium/run.sh & exit ; fi
    clear
    echo "Please add '* * * * 1 /Users/$(whoami)/.chromium/AutoUpdate.sh' Then press control+'o' and Enter and control+'x' without the double quotes. And now you can close the terminal. Press Enter"
    echo ""
    read PAUSE
    echo "Are you ready? Did you copy the line with Ctrl+'C'? Press Enter if it's true"
    echo ""
    read PAUSE
    export VISUAL=nano && crontab -e
  done
fi

if [ $KernelOS == "Linux" ]; then

  #CREATE CHROMIUM SHORTCUT
    echo "[Desktop Entry] " >> "/usr/share/applications/Chromium.desktop"
    echo "Version=1.0 " >> "/usr/share/applications/Chromium.desktop"
    echo "Type=Application " >> "/usr/share/applications/Chromium.desktop"
    echo "Name=Chromium " >> "/usr/share/applications/Chromium.desktop"
    echo "Comment=Chromium Web Browser " >> "/usr/share/applications/Chromium.desktop"
    echo "Exec=chromium " >> "/usr/share/applications/Chromium.desktop"
    echo "Icon=$HOME/.chromium/Icons/Chromium.png" >> "/usr/share/applications/Chromium.desktop"
    echo "Path=$HOME/.chromium" >> "/usr/share/applications/Chromium.desktop"
    echo "Terminal=false " >> "/usr/share/applications/Chromium.desktop"
    echo "StartupNotify=false " >> "/usr/share/applications/Chromium.desktop"
    
  #CREATE RESTORE CHROMIUM SHORTCUT
    echo "[Desktop Entry]" >> "/usr/share/applications/Restore Chromium.desktop"
    echo "Version=1.0" >> "/usr/share/applications/Restore Chromium.desktop"
    echo "Type=Application" >> "/usr/share/applications/Restore Chromium.desktop"
    echo "Name=Restore Chromium" >> "/usr/share/applications/Restore Chromium.desktop"
    echo "Comment=Restore the Last Version of Chromium" >> "/usr/share/applications/Restore Chromium.desktop"
    echo "Exec=bash $HOME/.Chromium/Remove\ Last\ Version.sh" >> "/usr/share/applications/Restore Chromium.desktop"
    echo "Icon=$HOME/.Chromium/Icons/Restore Chromium.png" >> "/usr/share/applications/Restore Chromium.desktop"
    echo "Path=" >> "/usr/share/applications/Restore Chromium.desktop"
    echo "Terminal=true" >> "/usr/share/applications/Restore Chromium.desktop"
    echo "StartupNotify=true" >> "/usr/share/applications/Restore Chromium.desktop"

  clear
  echo ""
  echo "  If you don't want to have autoupdates, press 's' and Enter. Otherwise, press Enter"
  echo ""
  read AUTO
  if [  "$AUTO" = "s" ] || [ "$AUTO" = "S" ]; then bash ~/.chromium/run.sh & exit ; fi
  sudo cat "/var/spool/cron/crontabs/$(whoami)" > /tmp/cronchromium 
  sudo echo "* * * * 1 $HOME/.chromium/AutoUpdate.sh" >> /tmp/cronchromium
  sudo cp -r /tmp/cronchromium "/var/spool/cron/crontabs/$(whoami)"
  sudo rm -r /tmp/cronchromium
  sudo cp $BASEDIR/Scripts/Aplication "/usr/bin/chromium"
fi
 
bash ~/.chromium/run.sh &
exit
