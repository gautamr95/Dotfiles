# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"
export SSH_ASKPASS=/usr/bin/ssh-askpass
eval "$(ssh-agent -s)"
ssh-add $HOME/.ssh/id_rsa &

#xautolock -time 10 -locker "i3lock-fancy -gf Roboto-Regular -- scrot -z" -notify 30 -notifier "xset dpms force off"  &
xset s 300 300
xss-lock -n $HOME/.config/i3/dim-screen.sh -- $HOME/.config/i3/lock-screen.sh &
