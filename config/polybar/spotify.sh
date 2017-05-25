#!/bin/bash

RED='\033[0;31m'
NC='\033[0m' # No Color

if [ "$(playerctl status >>/dev/null 2>&1; echo $?)" == "1" ]
then
    echo ""
      exit 0
fi

status=$(playerctl -p spotify status)

if [ "$status"  == "Playing" ] || [ "$status" == "Paused" ]
then
    title=$(playerctl -p spotify metadata xesam:title )
    artist=$(playerctl -p spotify metadata xesam:artist)
    album=$(playerctl -p spotify metadata xesam:album )
    if [ $status == "Playing" ]
    then
        echo -e " $artist || $album || $title"
    else
        echo -e "%{F#A54242} $artist || $album || $title"
    fi
else
    echo ""
fi
