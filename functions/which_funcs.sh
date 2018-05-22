##### ls -l which app #####
lw() {
    USAGE="Usage:  lw app-name. \n        Shows 'ls -lh' of app-name."
    if [ -z "$1" ]; then
        echo "$USAGE"
        #exit 1
    else
        WAPP=$(which ${1}) 
        if  [[ $? ]]; then
            echo $WAPP
        else
            ls -lh $WAPP
        fi
    fi
}
