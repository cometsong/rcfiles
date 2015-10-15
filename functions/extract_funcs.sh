#!/usr/bin/env sh

function extract()
{
    if [[ "x$1" == "x-h" || "x$1" == "x--help" || "x$1" == "x" ]]; then
        echo "Usage: extract filename"
        echo -n "  filename is of type: "
        echo "bz2, gz, rar, tar, tar.bz2, tbz2, tar.gz, tgz, zip, Z, 7z, xz, exe"
    fi
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2|*.tbz2)  tar xvjf $1     ;;
             *.tar.gz|*.tgz)    tar xvzf $1     ;;
             *.tar.xz)          tar xvJf $1    ;;
             *.tar)             tar xvf $1      ;;
             *.bz2)             bunzip2 $1      ;;
             *.gz)              gunzip $1       ;;
             *.rar)             unrar x $1      ;;
             *.zip)             unzip $1        ;;
             *.Z)               uncompress $1   ;;
             *.7z)              7z x $1         ;;
             *.xz)              unxz $1        ;;
             *.exe)             cabextract $1  ;;
             *)                 echo "'$1' cannot be extracted via >extract<" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}
