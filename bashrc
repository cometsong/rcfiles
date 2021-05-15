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

# init BashIt
[ -r "$HOME/.bashit.sh" ] && . "$HOME/.bashit.sh";

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

[ -r "$RCPATH/fasd/fasd" ] \
  && PATH=$RCPATH/fasd:$PATH \
  && eval "$(fasd --init auto)"

# Prompt Blastoff!
if type starship &>/dev/null ; then
  if type brew &>/dev/null; then
    _BREWBIN="$(brew --prefix)/bin/"
  fi
  export STARSHIP_CONFIG="$HOME/.starship.toml"
  eval "$(${_BREWBIN}starship init bash)"
  unset _BREWBIN
else
  # base prompting stuff
  source $RCPATH/set_prompt
fi
