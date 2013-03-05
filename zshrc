#.zshrc

# source .rcprofile as base shell config
if [ -f "$HOME/.rcprofile" ]; then
    . "$HOME/.rcprofile"
fi

# multi-dotfile setup
source $RCPATH/zsh_options     # load zsh options
source $RCPATH/zsh_compctl     # load compctl settings

# set cmd prompts:
# (day mnth date 24h)-(!hist)-(user@hostname)-(-zsh)-[~pwd]\n =>
PS1="${FG_G}(${FG_Y}%D{%a %b %d %H:%M:%S}${FG_G})-(!${FG_W}%h$FG_G)-(${FG_Y}%n${FG_G}@${FG_Y}%m${FG_G})-(${FG_Y}%N${FG_G})-[${FG_W}%~${FG_G}]${FG_W}
${NORM} => "

