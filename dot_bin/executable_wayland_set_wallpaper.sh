#!/bin/sh
#killall swaybg >/dev/null 2>&1 
varFileName=$(find ~/Pictures/wallpapers/ -maxdepth 1 -type f | shuf -n 1)
# echo "$varFileName"
swaybg -m fill -i "$varFileName"