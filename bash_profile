#/bin/bash
# ---------------------------------------------------------------------------- #
#                       bash_profile of JaminOne rcfiles                       #
# ---------------------------------------------------------------------------- #

## source bashrc
if [  -f $HOME/.bashrc ]; then
    . $HOME/.bashrc
fi


## multi-dotfile setup
source $HOME/.sh_config              # load base config 
# export BASH_COMPLETION='/Users/benjamin/code/rcfiles'
source $RCPATH/bash_comp


## completion
stty -ixon              # disable XON/XOFF flow control (^s/^q) 
complete -cf sudo       # Tab complete for sudo

#set menu-complete on
#set completion-ignore-case on
#set show-all-if-ambiguous on
#set visible-stats on

## sh-options
shopt -s cdspell        # This will correct minor spelling errors in a cd command.
shopt -s histappend     # Append to history rather than overwrite
shopt -s checkwinsize   # Check window after each command
shopt -s dotglob        # files beginning with . to be returned in the results of path-name expansion.

## set options
ulimit -S -c 0          # Don't want any coredumps.
set -o noclobber        # prevent overwriting files with cat
set -o ignoreeof        # stops ctrl+d from logging me out







echo Welcome to $HOSTNAME in bash!
# set cmd prompt for bash shells 
# (day mnth date 24h)-(!hist)-(user@hostname)-(bash)-[~pwd]\n =>
PS1='${FG_G}(${FG_Y}\d \t${FG_G})-(!${FG_W}\!${FG_G})-(${FG_Y}\u${FG_G}@${FG_Y}\h${FG_G})-(${FG_Y}\s${FG_G})-[${FG_W}\w\e[m${FG_G}]\n ${NORM}=> '

