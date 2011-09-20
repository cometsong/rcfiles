#.zshrc

# multi-dotfile setup
source $HOME/.sh_config        # load base config 
source $RCPATH/zsh_options     # load zsh options
source $RCPATH/zsh_compctl     # load compctl settings

echo "Welcome to $HOSTNAME"!

# set cmd prompts:
# ( mo-day 24time ) (! history) user @hostname [ ~pwd ]  \n➤>
PS1="${FG_GREEN}(${FG_YELLOW} %D{%m-%d %H:%M} ${FG_GREEN}) ${FG_GREEN}(${FG_WHITE}! %h$FG_GREEN) ${FG_YELLOW}%n @%m ${FG_GREEN}[ ${FG_WHITE}%~${FG_GREEN} ]${FG_WHITE}
${AT_NORMAL}➤> "

