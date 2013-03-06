# ---------------------------------------------------------------------------- #
#                                bashrc of rcfiles                             #
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

## completion
source $RCPATH/bash_comp

# set cmd prompt:
# based on https://wiki.archlinux.org/index.php/Color_Bash_Prompt#Wolfman.27s (with some mods)
function setPWD {  
    #   How many characters of the $PWD should be kept
    local pwdmaxlen=30
    #   Indicator that there has been directory truncation:
    local trunc_symbol="..."
    local DIR=$PWD
    [[ "$DIR" =~ ^"$HOME"(/|$) ]] && DIR="~${DIR#$HOME}"
    #local DIR=$( echo $PWD | awk -F$HOME '{print $2}'` )
    if [ ${#DIR} -gt $pwdmaxlen ]
    then
        local pwdoffset=$(( ${#DIR} - $pwdmaxlen ))
        DIR="${trunc_symbol}${DIR:$pwdoffset:$pwdmaxlen}"
    fi
    echo $DIR
}
# vc-awesome prompt format
export VCPROMPT_FORMAT="${FG_G}[${FG_B}%s:%b:%m%u${FG_G}]"
# (date-mnth 24h)-(!hist)-(@hostname)-(shell)-[~pwd]\n=>
PS1L='${FG_G}(${FG_Y}\D{%d-%b %T}${FG_G})-(!${FG_W}\!${FG_G})-(@${FG_Y}\h${FG_G})-(${FG_Y}\s${FG_G})-[${FG_W}$(setPWD)${FG_G}]'
PS1="${PS1L}
\$(vcprompt) => ${FG_W}${NORM}"
