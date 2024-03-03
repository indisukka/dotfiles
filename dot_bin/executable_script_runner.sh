#! /bin/bash
varScriptName="$(/usr/bin/ls ~/.bin/ | rofi -dmenu -theme dmenu -p 'Run Script')"
/usr/bin/bash "$varScriptName"