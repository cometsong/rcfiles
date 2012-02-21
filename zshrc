#.zshrc

# source .zprofile, because .zprofile does not always get automatically sourced
if [ -f "$HOME/.zprofile" ]; then
    . "$HOME/.zprofile"
fi

# multi-dotfile setup
source $RCPATH/zsh_options     # load zsh options
source $RCPATH/zsh_compctl     # load compctl settings

echo "Welcome to $HOSTNAME in zsh"!

# set cmd prompts:
# (day mnth date 24h)-(!hist)-(user@hostname)-(-zsh)-[~pwd]\n =>
PS1="${FG_G}(${FG_Y}%D{%a %b %d %H:%M:%S}${FG_G})-(!${FG_W}%h$FG_G)-(${FG_Y}%n${FG_G}@${FG_Y}%m${FG_G})-(${FG_Y}%N${FG_G})-[${FG_W}%~${FG_G}]${FG_W}
${NORM} => "

