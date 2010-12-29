#.zshrc

# Set path to rcfiles git repository
RCPATH=/usr/local/rcfiles
# multi-dotfile setup
source $RCPATH/config          # load base config
source $RCPATH/zsh_options     # load zsh options

echo "Welcome to $HOSTNAME"!

# set cmd prompt => user@host[pwd] \n[hh:mi]:➤ 
PS1="${fg_lgray}%n@${at_underl}%m${at_underloff}${fg_white}[${fg_green}%~${fg_white}]
${at_normal}> "
RPS1="$vcprompt $MAGENTA(%D{%m-%d %H:%M})$PR_NO_COLOR"

