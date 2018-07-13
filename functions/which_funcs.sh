##### ls -l which app #####
lw() {
    USAGE="Usage:  lw app-name.\n\tShows 'ls -lh' of app-name."
    if [ -z "$1" ]; then
        echo -e "$USAGE"
        #exit 1
    else
        WAPP=$(which ${1}) 
        if  [[ $? -gt 0 ]]; then
            echo $WAPP
        else
            ls -lh $WAPP
        fi
    fi
}
