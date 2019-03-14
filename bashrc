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
shopt -s extglob        # extended pattern matching in file-globbing, e.g. +([A-Z])

## set options
ulimit -S -c 0          # Don't want any coredumps.
set -o noclobber        # prevent overwriting files with cat
#set -o ignoreeof        # stops ctrl+d from logging me out
#set -o allexport        # auto export all vars for subsequent cmds #disble for _completion

set -o vi               # run bash in vi editing mode (instead of default emacs)
set editing-mode vi

# Use bash-completion, if available
if type brew &>/dev/null; then  # if [[ -n $APPLE ]]
  for COMPLETION in $(brew --prefix)/etc/bash_completion.d/*; do
    [[ -f $COMPLETION ]] && \
        source "$COMPLETION"
        #printf ' sourcing %s\n' $COMPLETION && \
  done
  [[ -f $(brew --prefix)/etc/profile.d/bash_completion.sh ]] && \
        . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
        #printf ' sourcing %s\n' "porofile.d/bash_completion.sh" && \
elif [[ -d $HOME/local/bash_completion ]]; then
    [[ -f $HOME/local/bash_completion/bash_completion ]] && \
        . "$HOME/local/bash_completion/bash_completion"
        #printf ' sourcing %s\n' "home-local bash_completion.sh" && \
fi
# /completion

# start setup prompting stuff
source $RCPATH/set_prompt

set_ps1() {
    # (date-mnth 24h)-(!hist)-(user@hostname)-(shell-ver)-[~pwd]-(vcprompt)\n=>
    PS1L="\[${DC}\](\[${RCy}\]\D{%d-%b %T}\[${DC}\])-(!\[${RCw}\]\!\[${DC}\])"
    PS1L+="-(\[${RCy}\]\u\[${DC}\]@\[${RCy}\]${HOSTNAME}\[${DC}\])"
    PS1L+="-(\[${RCy}\]\s-\v\[${DC}\])-[\[${RCw}\]\$(setPWD)\[${DC}\]]"
    export PS1="${PS1L}\$($VCPROMPT_BIN)\n=> \[${NORM}\]"
    unset PS1L
}; set_ps1
