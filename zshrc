# ---------------------------------------------------------------------------- #
#                                 zshrc of rcfiles                             #
# ---------------------------------------------------------------------------- #

# source .rcprofile as base shell config
if [ -f "$HOME/.rcprofile" ]; then
    . "$HOME/.rcprofile"
fi

# multi-dotfile setup
source $RCPATH/zsh_options     # load zsh options
source $RCPATH/zsh_compctl     # load compctl settings


# set cmd prompt:
source $RCPATH/prompt_colors

# vc-awesome prompt format
export VCPROMPT_TIMEOUT=2
export VCPROMPT_FORMAT="%{${FG_G}%}[%{${FG_B}%}%s:%b:%m%u%{${FG_G}%}]"

local PWDlength=30
# (date-mnth 24h)-(!hist)-(@hostname)-(shell)-[~pwd]\n=>
PS1L="%{${DC}%}(%{${RCy}%}%D{%d-%b %H:%M:%S}%}%{${DC}%})-(!%{${RCw}%}%h%{${DC}%})"
PS1L+="-(%{${RCy}%}%n%{${DC}%}@%{${RCy}%}%m%{${DC}%})"
PS1L+="-(%{${RCy}%}$(basename $SHELL)%{${DC}%})-[%{${RCw}%}%{%${PWDlength}<...<%~%<<${DC}%}]"
PS1="%{${PS1L}%}
\$(vcprompt) => %{${FG_W}%}%{${NORM}%}"
unset PS1L

echo Welcome to ${HOSTNAME} in ${SHELL##*/}!
