# ---------------------------------------------------------------------------- #
#                           bashrc of JaminOne rcfiles                         #
# ---------------------------------------------------------------------------- #

# source base etc files, varying based on OS
for BRC in bashrc bash.bashrc; do
    if [  -f /etc/$BRC ]; then
        . /etc/$BRC
    fi
done

# source .rcprofile as base shell config
if [ -f "$HOME/.rcprofile" ]; then
    . "$HOME/.rcprofile"
fi


## completion
source $RCPATH/bash_comp

## sh-options
shopt -s cdspell        # This will correct minor spelling errors in a cd command.
shopt -s histappend     # Append to history rather than overwrite
shopt -s checkwinsize   # Check window after each command
shopt -s dotglob        # files beginning with . to be returned in the results of path-name expansion.

## set options
ulimit -S -c 0          # Don't want any coredumps.
set -o noclobber        # prevent overwriting files with cat
set -o ignoreeof        # stops ctrl+d from logging me out

set -o vi               # run bash in vi editing mode (instead of default emacs)
set editing-mode vi


echo Welcome to $HOSTNAME in bash!
# set cmd prompt for bash shells 
# (day mnth date 24h)-(!hist)-(user@hostname)-(bash)-[~pwd]\n =>
PS1='${FG_G}(${FG_Y}\d \t${FG_G})-(!${FG_W}\!${FG_G})-(${FG_Y}\u${FG_G}@${FG_Y}\h${FG_G})-(${FG_Y}\s${FG_G})-[${FG_W}\w\e[m${FG_G}]\n ${NORM}=> '
