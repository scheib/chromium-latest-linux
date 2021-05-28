#!/bin/bash
if [ -d ~/.chromium ]; then
  echo ""
  echo "There is no Chromium installation on this user."
  read PAUSE
  exit
else
  rm -rf ~/.chromium 
  sudo rm /usr/bin/chromium
  if [ $KernelOS == "Darwin" ]; then rm -f /Applications/Chromium.app ; fi
  if [ $KernelOS == "Linux" ]; then rm -f /usr/share/applications/Chromium.desktop && rm -f /usr/share/applications/Restore\ Chromium.desktop ; fi
  clear
  while [ "$(crontab -l | grep "* * * * 1 $HOME/.chromium/AutoUpdate.sh")" = "* * * * 1 $HOME/.chromium/AutoUpdate.sh" ] ; do
    echo ""
    echo "   Please, delete the chromium auto-update line from the crontab."
    echo "   To do that, you have to delete it manually."
    echo ""
    echo "   After deleting that line, press Control+'o' and Enter to save it and Control+'x' to close it"
    echo ""
    echo "   Now, after you press Enter, it's going to throw you in a terminal text editor to delete the line"
    echo ""
    echo "PD: The line that you have to remove is this: '* * * * 1 $HOME/.chromium/AutoUpdate.sh'"
    echo ""
    read READY
    export VISUAL=nano && crontab -e
    clear
  done
  echo ""
  echo "Great! Finished. Your user doesn't have chromium anymore. Good Bye!"
  exit
fi
