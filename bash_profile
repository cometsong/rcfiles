# ---------------------------------------------------------------------------- #
#                            bash_profile of rcfiles                           #
# ---------------------------------------------------------------------------- #

# source bashrc if interactive
if [[ $- == *i* ]]; then 
    . ~/.bashrc
    echo Welcome to ${HOSTNAME} in ${SHELL##*/}!
else
    . $HOME/.rcprofile
fi

