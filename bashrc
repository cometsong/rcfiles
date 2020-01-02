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
if [ -r "$HOME/.rcprofile" ]; then . "$HOME/.rcprofile"; fi

## sh-options
shopt -s cdspell        # This will correct minor spelling errors in a cd command.
shopt -s histappend     # Append to history rather than overwrite (set -H)
shopt -s checkwinsize   # Check window after each command
shopt -s dotglob        # files beginning with . to be returned in the results of path-name expansion.
shopt -s extglob        # extended pattern matching in file-globbing, e.g. +([A-Z])

## set options
ulimit -S -c 0          # Don't want any coredumps.
set -o noclobber        # -C prevent overwriting files with cat
#set -o ignoreeof        # stops ctrl+d from logging me out
#set -o allexport        # -a auto export all vars for subsequent cmds #disble for _completion

set -o vi               # run bash in vi editing mode (instead of default emacs)
set editing-mode vi

# Use bash-completion, if available
if type brew &>/dev/null; then  # if [[ -n $APPLE ]]
  [[ -r $(brew --prefix)/etc/profile.d/bash_completion.sh ]] && \
     . "$(brew --prefix)/etc/profile.d/bash_completion.sh"
elif [[ -r $HOME/local/bash-completion/bash_completion ]]; then
  . "$HOME/local/bash_completion/bash_completion"
fi
# /completion

# setup prompting stuff
set_ps1_venv() {
  local VENVPS1
  [[ -z "${VIRTUAL_ENV}" ]] || {
  VENVPS1="=(\[${b_Yl}\]\[${f_Bk}\]$(basename "$VIRTUAL_ENV")\[${NORM}\]\[${DC}\])=>"
  PS1="${PS1/=>/$VENVPS1}"; }
}
set_ps1() {
    # (date-mnth 24h)-(!hist)-(user@hostname)-(shell-ver)-[~pwd]-(vcprompt)\n=>
    PS1L="\[${DC}\](\[${RCy}\]\D{%d-%b %T}\[${DC}\])-(!\[${RCw}\]\!\[${DC}\])"
    PS1L+="-(\[${RCy}\]\u\[${DC}\]@\[${RCy}\]${HOSTNAME}\[${DC}\])"
    PS1L+="-(\[${RCy}\]\s-\v\[${DC}\])-[\[${RCw}\]\$(setPWD)\[${DC}\]]"
    export PS1="${PS1L}\$($VCPROMPT_BIN)\n=> \[${NORM}\]"
    unset PS1L
    set_ps1_venv
}; set_ps1

