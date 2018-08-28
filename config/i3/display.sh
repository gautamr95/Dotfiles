#!/bin/bash

main=$(xrandr | grep " connected" | cut -d " " -f1 | head -1)
display=$(xrandr | grep " connected" | cut -d " " -f1 | tail -1)
xrandr --output $display --rotate normal --auto --right-of $main --primary
$HOME/.fehbg
