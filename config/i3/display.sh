#!/bin/bash

main=$(xrandr | grep " connected" | cut -d " " -f1 | sort | head -1)
second=$(xrandr | grep " connected" | cut -d " " -f1 | sort | tail -1)
xrandr --output $main --rotate normal --auto --primary
xrandr --output $second --rotate normal --auto --right-of $main --primary
$HOME/.fehbg
