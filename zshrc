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
# vc-awesome prompt format
export VCPROMPT_FORMAT="${FG_G}[${FG_B}%s:%b:%m%u${FG_G}]"
local PWDlength=30
# (date-mnth 24h)-(!hist)-(@hostname)-(shell)-[~pwd]\n=>
PS1L="${FG_G}(${FG_Y}%D{%d-%b %H:%M:%S}${FG_G})-(!${FG_W}%h$FG_G)-(${FG_G}@${FG_Y}%m${FG_G})-(${FG_Y}%N${FG_G})-[${FG_W}%$PWDlength<...<%~%<<${FG_G}]"
PS1="${PS1L}
\$(vcprompt) => ${FG_W}${NORM}"
