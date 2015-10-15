#!/usr/bin/env sh

##### Dir Functions #####
function mdc() { 
    mkdir -p $1 
    cd $1 
}

# from cd_dot.sh (more comments for readability in there)
function cd() { 
    if [[ $1 =~ \.\.\. ]] 
    then
        YESDOTS=$(echo $1 | sed 's/^\(\.*\)\(.*\)/\1/')
        NOTDOTS=$(echo $1 | sed 's/^\(\.*\)\(.*\)/\2/')
        NOTDOTS=${NOTDOTS/\//}
        DOTS=${#YESDOTS}
        DOTDIR=''
        while [ $DOTS -gt 1 ]; do
            DOTDIR="$DOTDIR../" 
            DOTS=$((DOTS - 1))
        done
        cd $DOTDIR$NOTDOTS
    else
        builtin cd $1
    fi
}
