#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ BASH_IT! ~~~~~

export BASH_IT="$HOME/code/rcfiles/bash-it" # Path to the bash it configuration
export BASH_IT_THEME='' # Starship gets control!

unset  MAILCHECK # Don't check mail when opening terminal.
export IRC_CLIENT='weechat' # Change this to your console based IRC client of choice.

export GIT_HOSTING='git.cometsong.net' # Your place for hosting Git repos. I use this for private repos.
export SCM_CHECK=false # Set this to false to turn off version control status checking within the prompt for all themes

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else), Will otherwise fall back on $USER.
export SHORT_USER=${USER:0:8}

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else), Will otherwise fall back on $HOSTNAME.
export SHORT_HOSTNAME=$(hostname -s)

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Set vcprompt executable path for scm advance info in prompt (demula theme) https://github.com/djl/vcprompt
export VCPROMPT_EXECUTABLE=

# for use with 'pj' project plugin
export PROJECT_PATHS="${HOME}/GDX/projects:${HOME}/code"

# Load Bash It
source "$BASH_IT"/bash_it.sh
