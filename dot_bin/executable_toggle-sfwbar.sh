#!/bin/sh
# killall sfwbar
pgrep -x sfwbar >/dev/null && killall sfwbar || sfwbar