#!/bin/bash


sudo -u $3 /usr/local/bin/dockutil --remove all  --no-restart "/Users/$3"

sudo -u $3 /usr/local/bin/dockutil --add '/Applications/Safari.app' --position 2 --no-restart "/Users/$3"
sudo -u $3 /usr/local/bin/dockutil --add '/Applications/Firefox.app' --position 3 --no-restart "/Users/$3"
sudo -u $3 /usr/local/bin/dockutil --add '/Applications/Preview.app' --position 4 --no-restart "/Users/$3"
sudo -u $3 /usr/local/bin/dockutil --add '/Applications/Adobe Reader.app' --position 5 --no-restart "/Users/$3"
sudo -u $3 /usr/local/bin/dockutil --add '/Applications/System Preferences.app' --position 6 --no-restart "/Users/$3"
sudo -u $3 /usr/local/bin/dockutil --add '/Applications/TextEdit.app' --position 7 --no-restart "/Users/$3"
sudo -u $3 /usr/local/bin/dockutil --add '/Applications/PCClient.app' --no-restart "/Users/$3"
sudo -u $3 /usr/local/bin/dockutil --add '/Applications/Microsoft Office 2008/Microsoft Excel.app' --no-restart "/Users/$3"
sudo -u $3 /usr/local/bin/dockutil --add '/Applications/Microsoft Office 2008/Microsoft PowerPoint.app' --no-restart "/Users/$3"
sudo -u $3 /usr/local/bin/dockutil --add '/Applications/Microsoft Office 2008/Microsoft Word.app' --no-restart "/Users/$3"
#sudo -u $3 /usr/local/bin/dockutil -'~/Documents' --view fan --display folder "/Users/$3"
sudo -u $3 /usr/local/bin/dockutil -'/WCMC Resource/' --view fan --display folder "/Users/$3"

# Relaunch Dock
/usr/bin/sudo killall Dock

osascript tell application "PCClient" to activate

exit 0
