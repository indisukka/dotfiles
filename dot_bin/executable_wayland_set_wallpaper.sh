#!/bin/sh
killall swaybg
varFileName=$(find ~/Pictures/wallpapers/ -type f | shuf -n 1)
# echo "$varFileName"
swaybg -i "$varFileName" -m fill