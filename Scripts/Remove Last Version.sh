#!/bin/bash
cd $(dirname $0)
clear
echo "#########################################################################"
echo "#        If you are sure what you want to do press Enter.               #"
echo "# WARNING: This Script deletes the last downloaded version of Chromium. #"
echo "#           But it doesn't stop the automatical updates.                #"
echo "#             Edit the crontab manually to avoid that                   #"
echo "#########################################################################"
read READY
clear



touch Update_Data/Pre-Pre-Pre-Version
touch Update_Data/Pre-Pre-Version
touch Update_Data/Pre-Version
touch Update_Data/Version
echo "" > Update_Data/Pre-Pre-Pre-Version

NEW_VERSION=$(cat Update_Data/Version)
OLD_VERSION=$(cat Update_Data/Pre-Version)

cat Update_Data/Pre-Pre-Pre-Version > Update_Data/Pre-Pre-Version
cat Update_Data/Pre-Pre-Version > Update_Data/Pre-Version
cat Update_Data/Pre-Version > Update_Data/Version

if [ "$NEW_VERSION" == "" ]; then
    rm -rf latest
else
    rm -rf "$NEW_VERSION"
    ln -s ./$OLD_VERSION ./latest
fi

clear
echo
echo
echo "          *****************************"
echo "          *    REMOVAL SUCCESSFUL     *"
echo "          *****************************"
read READY
exit
