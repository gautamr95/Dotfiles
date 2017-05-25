#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

# invoke global X session script
. /etc/X11/Xsession

# xss-lock -- dm-tool lock

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

