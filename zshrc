#.zshrc

# multi-dotfile setup
source $HOME/.sh_config        # load base config 
source $RCPATH/zsh_options     # load zsh options
source $RCPATH/zsh_compctl     # load compctl settings

echo "Welcome to $HOSTNAME"!

# set cmd prompt => user@host[pwd] \n[hh:mi]:➤ 
PS1="${fg_lgray}%n @${at_underl}%m${at_underloff}${fg_white}[${fg_green}%~${fg_white}]
${at_normal}> "
RPS1="$MAGENTA(%D{%m-%d %H:%M})$PR_NO_COLOR"

