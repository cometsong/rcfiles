# ---------------------------------------------------------------------------- #
#                            bash_profile of rcfiles                           #
# ---------------------------------------------------------------------------- #

# source bashrc if exists
if [ -f ~/.bashrc ]; then . ~/.bashrc; fi

## completion
source $RCPATH/bash_comp

# set cmd prompt for bash shells 
# (day mnth date 24h)-(!hist)-(user@hostname)-(bash)-[~pwd]\n =>
PS1='${FG_G}(${FG_Y}\d \t${FG_G})-(!${FG_W}\!${FG_G})-(${FG_Y}\u${FG_G}@${FG_Y}\h${FG_G})-(${FG_Y}\s${FG_G})-[${FG_W}\w\e[m${FG_G}]\n ${NORM}=> '
