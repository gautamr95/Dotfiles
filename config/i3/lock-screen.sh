#!/bin/bash
#scrot -z -m /tmp/scrot.png
#convert -scale 10% -scale 1000% /tmp/scrot.png /tmp/lock.png
i3lock -k -e -B=10
sleep 1
xset dpms force off
