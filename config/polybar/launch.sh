#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

tray_pos="right"

# Launch bar
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1 | sort); do
    MONITOR=$m TRAY_POS=$tray_pos polybar --reload main &
    tray_pos=""
  done
else
  polybar --reload main &
fi

echo "Bars launched..."
