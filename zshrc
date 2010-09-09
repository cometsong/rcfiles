###########################
#                         #
#     JaminOne, v0.4      #
#                         #
###########################

export PATH=/usr/local/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/libexec:${HOME}/bin
export PATH=${PATH}:/usr/local/mysql/bin:/usr/local/git/bin:/opt/php/bin

# Set path to rcfiles git repository
RCPATH=~/code/rcfiles

# multi-dotfile setup
source $RCPATH/colors          # load color vars
source $RCPATH/config          # load base config
source $RCPATH/aliases         # load aliases 
source $RCPATH/zsh_options     # load zsh options
source $RCPATH/sh_functions    # load sh functions

echo "Welcome to $HOSTNAME"!


# Update the command prompt to be <current_directory> (<user>@<machine>) [git_branch]
# setopt prompt_subst
#PROMPT='%~ %{$fg[white]%}(%n@%m%) $(vcprompt)%{$reset_color%}
#→ '

# set cmd prompt => user@host[pwd] \n[hh:mi]:➤ 
PS1="${fg_lgray}%n@${at_underl}%m${at_underloff}${fg_white}[${fg_blue}%~${fg_white}]
${at_normal}> "
RPS1="$vcprompt $MAGENTA(%D{%m-%d %H:%M})$PR_NO_COLOR"

