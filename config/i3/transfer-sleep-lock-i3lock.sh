#!/bin/bash

# Example locker script -- demonstrates how to use the --transfer-sleep-lock
# option with i3lock's forking mode to delay sleep until the screen is locked.

## CONFIGURATION ##############################################################

alpha="55"
red=$(xrdb -query | grep "*color9:" | cut -f2)
green=$(xrdb -query | grep "*color10:" | cut -f2)
blue=$(xrdb -query | grep "*color6:" | cut -f2)
yellow=$(xrdb -query | grep "*color3:" | cut -f2)
black=$(xrdb -query | grep "*background:" | cut -f2)
white=$(xrdb -query | grep "*foreground:" | cut -f2)

# Options to pass to i3lock
i3lock_options="-k -e -B=10 \
    --indicator \
    --inside-color=$black \
    --insidever-color=$blue \
    --insidewrong-color=$red \
    --ring-color=$green$alpha\
    --ringver-color=$blue$alpha \
    --ringwrong-color=$red$alpha \
    --line-uses-ring \
    --keyhl-color=$green \
    --bshl-color=$red \
    --separator-color=$black$alpha\
    --verif-color=$white \
    --wrong-color=$white \
    --modif-color=$white \
    --layout-color=$white \
    --time-color=$white \
    --date-color=$white \
    --greeter-color=$white \
    --timeoutline-color=$black \
    --dateoutline-color=$black \
    --layoutoutline-color=$black \
    --verifoutline-color=$black \
    --wrongoutline-color=$black \
    --greeteroutline-color=$black \
    --modifoutline-color=$black \
    --time-font=Hack \
    --date-font=Hack \
    --layout-font=Hack \
    --verif-font=Hack \
    --wrong-font=Hack \
    --greeter-font=Hack \
    "

id=$(xinput | grep -i Mouse | cut -f2 | cut -d "=" -f2 | sort -r | head -1)

# Run before starting the locker
pre_lock() {
    #mpc pause
    playerctl pause
    xset dpms force off
    xinput --set-prop $id "Device Enabled" "0"
    return
}

# Run after the locker exits
post_lock() {
    xinput --set-prop $id "Device Enabled" "1"
    return
}

###############################################################################

pre_lock

# We set a trap to kill the locker if we get killed, then start the locker and
# wait for it to exit. The waiting is not that straightforward when the locker
# forks, so we use this polling only if we have a sleep lock to deal with.
if [[ -e /dev/fd/${XSS_SLEEP_LOCK_FD:--1} ]]; then
    kill_i3lock() {
        pkill -xu $EUID "$@" i3lock
    }

    trap kill_i3lock TERM INT

    # we have to make sure the locker does not inherit a copy of the lock fd
    i3lock $i3lock_options {XSS_SLEEP_LOCK_FD}<&-

    # now close our fd (only remaining copy) to indicate we're ready to sleep
    exec {XSS_SLEEP_LOCK_FD}<&-

    while kill_i3lock -0; do
        sleep 0.5
    done
else
    trap 'kill %%' TERM INT
    i3lock -n $i3lock_options &
    wait
fi

post_lock
