#!/bin/bash
#===============================================================================
# Update all git submodules (on a system where "git submodule" does not exist.)
# init the submods if their folder does not exist.
#===============================================================================

if [ ! -s .gitmodules ]; then
    echo
    echo "The file .gitmodules either does not exist or is empty. "
    echo "This script must be run from a git repository's main directory."
    echo
    exit
fi

# keep starting dir for return cd's
MAINDIR=$PWD
#echo $MAINDIR

# grep out 2 lines from each submodule, sed away all ' 's
for sub in `grep 'path\|url' .gitmodules | sed 's/ //g' `
do
    if [ `expr $sub : 'path=\(.*\)'` ]; then    # path line
        SUBPATH=${sub/path\=/}
    elif [ `expr $sub : 'url=\(.*\)'` ]; then # url line
            SUBURL=${sub/url=/}
            if [ ! -e $SUBPATH ]; then
                echo "git clone  $SUBURL    $SUBPATH"
                git clone $SUBURL $SUBPATH
            else
                echo "Updating $SUBURL"
                cd $SUBPATH
                echo "git pull origin master"
                git pull origin master
                cd $MAINDIR
            fi
    fi
done


