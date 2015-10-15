#!/usr/bin/env sh

##### Find a file with a pattern in name ##### 
function ff() {
    find . -type f -iname '*'$*'*' -ls ; 
}

##### Find a file with pattern $1 in name and Execute $2 on it ##### 
function fe() {
    find . -type f -iname '*'${1:-}'*' -exec ${2:-file} {} \;  ; 
}

##### Find a pattern in a set of files and highlight them #####
# (needs a recent version of egrep)
function fstr()
{
    OPTIND=1
    local case=""
    local usage="fstr: find string in files.
Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
    do
        case "$opt" in
        i) case="-i " ;;
        *) echo "$usage"; return;;
        esac
    done
    shift $(( $OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
        echo "$usage"
        return;
    fi
    find . -type f -name "${2:-*}" -print0 | \
    xargs -0 egrep --color=always -sn ${case} "$1" 2>&- | more 

}
