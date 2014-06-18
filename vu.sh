#!/bin/bash
#    Copyright (C) 2013 SferaDev (original code)
#    Copyright (C) 2014 VanillaRoms (modded code)

#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.

#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.

#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>

clear
echo "Welcome $USER"
echo
echo "What can I do for you?"
echo "Option 0: Repo init VU"
echo "Option 1: Repo sync"
echo "Option 2: Build mako"
echo "Option 3: Build hammerhead"
echo "Option 4: Create a changelog"
echo

read -p "Your option: " OPTION

case $OPTION in
"0")
echo "Repo initialing..."
repo init -u https://github.com/VanillaUnicorn/platform_manifest.git -b kitkat -g all,kernel,device,vendor
;;
"1")
echo "Repo syncing..."
repo sync -j12
;;
"2")
echo "Building Mako..."
source build/envsetup.sh
rm -rf out/
read -p "Threads (usually 2-6): " THREADS
brunch mako -j$THREADS
;;
"3")
echo "Building Hammerhead..."
source build/envsetup.sh
rm -rf out/
read -p "Threads (usually 2-6): " THREADS
brunch hammerhead -j$THREADS
;;
"4")
echo "Generating Changelog..."
rm -rf ChangeLog
read -p "Since (YYYY-MM-DD): " CHANGELOG_DATE
repo forall -c git log --oneline --since={$CHANGELOG_DATE} --no-merges > ChangeLog
gedit ChangeLog
;;
esac

return 0
