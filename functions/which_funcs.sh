#!/usr/bin/env sh

##### ls -l which app #####
function lw() {
    USAGE="Usage:  lw app-name. \n        Shows 'ls -lh' of app-name."
    if [ -z "$1" ]; then
        echo "$USAGE"
        #exit 1
    else
        WAPP=$(which ${1}) 
        if  [[ $WAPP =~ not\ found ]]; then
            echo $WAPP
        else
            ls -lh $WAPP
        fi
    fi
}