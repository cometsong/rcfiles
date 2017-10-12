#!/usr/bin/env bash
# ---------------------------------------------------------------------------- #
#                                bashrc of rcfiles                             #
# ---------------------------------------------------------------------------- #

# source base etc files, varying based on OS
for BRC in bashrc bash.bashrc; do
    if [  -r /etc/$BRC ]; then
        . /etc/$BRC
    fi
done
unset BRC

# source .rcprofile as base shell config
if [ -r "$HOME/.rcprofile" ]; then
    . "$HOME/.rcprofile"
fi

## sh-options
shopt -s cdspell        # This will correct minor spelling errors in a cd command.
shopt -s histappend     # Append to history rather than overwrite
shopt -s checkwinsize   # Check window after each command
shopt -s dotglob        # files beginning with . to be returned in the results of path-name expansion.

## set options
ulimit -S -c 0          # Don't want any coredumps.
set -o noclobber        # prevent overwriting files with cat
#set -o ignoreeof        # stops ctrl+d from logging me out
set -o allexport        # auto export all vars for subsequent cmds

set -o vi               # run bash in vi editing mode (instead of default emacs)
set editing-mode vi

# Use bash-completion, if available
#BCOMPS="/etc/bash_completion"
#[[ -n $APPLE ]] && BCOMPS+=" /usr/local/etc/bash_completion"
#for B in ${BCOMPS}; do
#    [[ -r $B ]] && . $B
#done && unset B BCOMPS

# set cmd prompt:
# based on https://wiki.archlinux.org/index.php/Color_Bash_Prompt#Wolfman.27s (with some mods)
function setPWD {
    #   How many characters of the $PWD should be kept
    local pwdmaxlen=30
    #   Indicator that there has been directory truncation:
    local trunc_symbol="..."
    local DIR=$PWD
    [[ "$DIR" =~ ^"$HOME"(/|$) ]] && DIR="~${DIR#$HOME}"
    if [ ${#DIR} -gt $pwdmaxlen ]
    then
        local pwdoffset=$(( ${#DIR} - $pwdmaxlen ))
        DIR="${trunc_symbol}${DIR:$pwdoffset:$pwdmaxlen}"
    fi
    echo $DIR
}

# set colors
source $RCPATH/prompt_colors

# vc-awesome prompt format
export VCPROMPT_TIMEOUT=100
export VCPROMPT_FORMAT="-${DC}(${FG_B}%s:%b:%m%u%a${DC})"
# oython version check, as vcprompt requires Py 2.7+
PY_VER="$(python -c 'import sys; print(sys.version[0:3])' | sed 's/\.//')"
if (( "$PY_VER" <= "27" )) ; then
    VCPROMPT_BIN='echo -n ""'
else
    VCPROMPT_BIN='vcprompt'
fi


# (date-mnth 24h)-(!hist)-(user@hostname)-(shell-ver)-[~pwd]-(vcprompt)\n=>
PS1L="\[${DC}\](\[${RCy}\]\D{%d-%b %T}\[${DC}\])-(!\[${RCw}\]\!\[${DC}\])"
PS1L+="-(\[${RCy}\]\u\[${DC}\]@\[${RCy}\]\h\[${DC}\])"
PS1L+="-(\[${RCy}\]\s-\v\[${DC}\])-[\[${RCw}\]\$(setPWD)\[${DC}\]]"
PS1="${PS1L}\$($VCPROMPT_BIN)
=> \[${NORM}\]"
unset PS1L
