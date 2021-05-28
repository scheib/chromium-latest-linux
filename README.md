# Chromium Updater for Mac & Linux            ![image](https://user-images.githubusercontent.com/84420737/118993821-360ec700-b95c-11eb-8d6d-b07f7d79ff53.png)
### Welcome to the Open Source Chromium Browser!
This project is a fork from the original creator: scheib. And I have to say thanks to gamgi to give me the idea for the Mac OS implementation in the functionality of this script.

**With these scripts you can install and Update Chromium in your home directory in GNU/Linux and Mac OS X**. You must have the crontab installed for the automatic updates), **have installed the function notify-send and curl** and you have to **be in the sudoers file** (have access to the root 'sudo').
  For example: To install notify-send and curl in debian based distros, you have to execute:
  ```
  sudo apt install libnotify-bin curl
  ```
## Instalation:
  For the instalation you have to download this package and unzip it. After that you have to select the unziped folder, move it to ~/.Chromium (changing te name of that folder to ".chromium" and put it in your home directory), so, from a terminal, execute this lines of code one by one:
```
cd ~/Downloads
git clone https://github.com/sudo-Eze/chromium_updater
mv chromium_updater ~/.chromium
cd ~/.chromium/
sudo bash INSTALL.sh
```
  And with this it installs chromium in ~/.Chromium and open it when it finalizes.

## Ready To Go!
  Thank you! All the aportation and comments are good recived!.
