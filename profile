# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin directories
PATH="$HOME/bin:$HOME/.local/bin:$PATH"

export GO15VENDOREXPERIMENT=1
export PATH="$HOME/ti/ccsv7/eclipse:$PATH"

export PATH="$PATH:/opt/microchip/xc8/v1.45/bin"
export GOPATH="/home/gautam/co/backend/go"
export PATH="/usr/local/go/bin:$PATH"
export NVM_DIR=$HOME/.nvm
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
alias gulp="yarn run gulp"
alias taskrunner="go run /home/gautam/co/backend/go/src/samsaradev.io/app/taskrunner/*.go"
export PATH="$HOME/.nodenv/bin:$PATH"
eval "$(nodenv init --no-rehash -)" 2> /dev/null
(nodenv rehash &) 2> /dev/null # background rehash
