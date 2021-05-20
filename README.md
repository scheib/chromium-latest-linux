# Chromium Updater for Mac & Linux            ![image](https://user-images.githubusercontent.com/84420737/118993821-360ec700-b95c-11eb-8d6d-b07f7d79ff53.png)

### Welcome to the Open Source Chromium Browser!

This proyect is a fork from the orginal creator: scheib.

**With these scripts you can install and Update Chromium in your home directory in GNU/Linux and Mac OS X**. You must have the crontab installed for the automatic updates (Next function), have installed the function "notify-send" and have the folders of your home directory in English, otherwise you must edit the install script to change it for the name of your Desktop folder.

## Instalation:

  For the instalation you have to download this package and unzip it. After that you have to go to the unziped folder, copy it to ~/.Chromium and from a terminal, execute this line of code in that folder:
```
sudo bash ./update.sh
sudo bash ./run.sh
```
  And with this it installs chromium in ~/.Chromium and creates desktop's shortcut to the application.

## Enable Automaticals updates:
  If you're on Mac OS, you have to manually edit the crontab to enable automatic updates. If you're on GNU/Linux, you don't have to do anything, it's enable by defect. Let's begin (for Mac OS's users). First, you have to open a terminal and type the following:
  ```
  whoami
  ```
  You have to anote or remember that because we're going to use it later. Now type the following:
  ```
  sudo export VISUAL=nano; crontab -e
 ```
 It will open a command line text editor, so you have to type this:
 ```
 * * * * 1 /Users/YOUR_USER/.chromium/AutoUpdate.sh
 ```
  Replacing "YOUR_NAME" with your username that said when you executed "whoami". Now you press control+"o" and Enter and control+"x" without the double quotes. And now you can close it.
  
  If you don't want to edit your crontab, you have to manually update it whenever you want whit this command.
  ```
  bash ~/.chromium/update.sh
  ```
  
## Ready To Go!

Thank you! All the aportation and comments are good recived!.
