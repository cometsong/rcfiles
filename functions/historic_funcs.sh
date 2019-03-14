hist_uname() { #{{{ 
    ### Define HISTFILE specific to server's uname for simple separation
    history -r # read from current histfile
    host=${HOSTNAME:="$(uname -n)"} # if HOSTNAME else uname
    HISTFILE="$HOME/.history.${host// /}" # set new history file
    # ya don't got the histfile? touch it, happily
    if [[ ! -f $HISTFILE ]]; then touch $HISTFILE; fi
    history -a # append to current history file

    # return value of HISTFILE
    echo $HISTFILE
} #}}} 
#export HISTFILE=$(hist_uname)


mycd() { #{{{ # recd from Jethro 20150825 
    history -w # write current history file
    builtin cd "$@" # do actual cd
    local HISTDIR="$HOME/.dir_bash_history$PWD" # use nested folders
    if [ ! -d "$HISTDIR" ]; then # create folder when necessary
        mkdir -p "$HISTDIR"
    fi
    export HISTFILE="$HISTDIR/bash_history.txt" # set new history file
    history -c # clear memory
    history -r # read from current histfile
} #}}} 
#alias cd="mycd"
#export HISTFILE="$HOME/.dir_bash_history$PWD/bash_history.txt"


# forget most recent command
forgetcmd() { #{{{ 
    history -d $((HISTCMD-2));
} #}}} 


# delete a series of cmds from shell history
delhist() { #{{{ 
    USAGE="Usage delhist <old_hist_num> <newer_hist_num>";
    Old=${1?"$USAGE"};
    New=${2?"$USAGE"};
    for h in $(seq $New -1 $Old); do
        echo -n "forgetting $h: " && \
        if history -d "$h" ; then
        echo "gone"; fi;
    done
} #}}} 

