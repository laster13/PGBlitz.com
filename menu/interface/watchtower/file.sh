#!/bin/bash
#
# [Ansible Role]
#
# GitHub:   https://github.com/Admin9705/PlexGuide.com-The-Awesome-Plex-Server
# Author:   Admin9705
# URL:      https://plexguide.com
#
# PlexGuide Copyright (C) 2018 PlexGuide.com
# Licensed under GNU General Public License v3.0 GPL-3 (in short)
#
#   You may copy, distribute and modify the software as long as you track
#   changes/dates in source files. Any modifications to our software
#   including (via compiler) GPL-licensed code must also be made available
#   under the GPL along with build & install instructions.
#
#################################################################################
menu=$(cat /var/plexguide/final.choice)

  echo ""
  echo "-----------------------------------------------------"
  echo "SYSTEM MESSAGE: Please Read the Following Information"
  echo "-----------------------------------------------------"
  echo ""
  echo "NOTE: WatchTower Auto-Updates Your Containers! Soon"
  echo "as a containers is released, it updates!"
  echo ""
  echo "WARNING: Auto-Updates can be problematic if the"
  echo "released containers is bugged! Rare, but happens!"
  echo ""
  read -n 1 -s -r -p "Press [ANY KEY] to Continue"

  ### part 2
  typed=nullstart
  prange="1 2 3"
  tcheck=""
  break=off
  while [ "$break" == "off" ]; do
    echo "--------------------------------------------------------"
    echo "SYSTEM MESSAGE: Set WatchTower Preference"
    echo "--------------------------------------------------------"
    echo ""
    echo "1. EXIT WatchTower Interface"
    echo "2. Containers:  All Auto-Update"
    echo "3. Containers:  All Auto-Update | Except Plex & Emby"
    echo "4. Containers:  Never Update    | Conducting Manual Updates"
    echo ""
    read -p 'Type a Number from 1 - 4 | PRESS [ENTER]: ' typed
    tcheck=$(echo $prange | grep $typed)
    echo ""

if [ "$typed" != "1" ]; then

    if [ "$tcheck" == "" ]; then
      echo "--------------------------------------------------------"
      echo "SYSTEM MESSAGE: Failed! Type a Number from 1 - 4"
      echo "--------------------------------------------------------"
      echo ""
      read -n 1 -s -r -p "Press [ANY KEY] to Continue "
      echo ""
      echo ""
    else
      echo "----------------------------------------------"
      echo "SYSTEM MESSAGE: Passed! WatchTower Pref Set!"
      echo "----------------------------------------------"
      echo ""
      echo $typed > /var/plexguide/watchtower.id
      read -n 1 -s -r -p "Press [ANY KEY] to Continue "
      break=on
    fi
  done

  break=no
  while [ "$break" == "no" ]; do
  echo ""
  read -p 'Type a Sever ID & Then Press [ENTER]: ' typed
  #typed=typed+0
    echo ""
    echo "-------------------------------------------------"
    echo "SYSTEM MESSAGE: Server ID - $typed"
    echo "-------------------------------------------------"
    echo ""
    read -p "Continue with the Set Server ID (y/n)? " -n 1 -r

    if [[ ! $REPLY =~ ^[Yy]$ ]]
    then
      echo ""
      echo "---------------------------------------------------"
      echo "SYSTEM MESSAGE: [Y] Key was NOT Selected"
      echo "---------------------------------------------------"
      echo ""
      echo "You will be able to set the Server ID Again!"
      echo
      read -n 1 -s -r -p "Press [ANY KEY] to Continue "
      echo "";
    else
      echo ""
      echo "---------------------------------------------------"
      echo "SYSTEM MESSAGE: Server ID - $typed"
      echo "---------------------------------------------------"
      echo ""
      echo "Your Server ID is Now Set! Thank you!"
      echo ""
      echo $typed > /var/plexguide/watchtower.id
      break=yes
      read -n 1 -s -r -p "Press [ANY KEY] to Continue "
      echo "";
    fi
  done

#### Final fi
fi

idtest=$(cat /var/plexguide/watchtower.id)
if [ "$idtest" == "NOT-SET" ]; then
  echo ""
  echo "---------------------------------------------------"
  echo "SYSTEM MESSAGE: Never Set a WatchTower Preference!"
  echo "---------------------------------------------------"
  echo ""
  echo "NOTE: You Must Set Once! Restarting the Process!"
  echo
  read -n 1 -s -r -p "Press [ANY KEY] to Continue "
  echo watchtowerid > /var/plexguide/type.choice && bash /opt/plexguide/menu/core/scripts/main.sh
  exit
fi
