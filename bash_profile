# ---------------------------------------------------------------------------- #
#                            bash_profile of rcfiles                           #
# ---------------------------------------------------------------------------- #

# If not running interactively, setup background-able files
case $- in
  *i*)
    . ~/.bashrc;
    echo Welcome to ${HOSTNAME} in ${SHELL##*/}!;
    ;;
  *) . $HOME/.rcprofile; return;;
esac
