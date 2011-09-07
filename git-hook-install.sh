#!/bin/bash -
#===============================================================================
#          FILE:  git-hook-install.sh
#   DESCRIPTION:  Installs several git hook scripts to run ctags after each repo update
#  REQUIREMENTS:  Exuberant ctags
#        AUTHOR:  B. Leopold (jaminwebdesign at gmail dot com)
#       CREATED:  2011-08-30 16:38:15+0200
#===============================================================================

set -o nounset                              # Treat unset variables as an error
set -o errexit                              # Exit with any error (no snowball effect)

# TODO : test whether above dev null output redirect can be placed into ctags hook file

usage ()
{
    echo
    echo "Usage: $0 [install [<hook_name>]] [-h|--help]"
    echo "  default installation is all hook files"
}

# Variables:
CTAGS='/usr/local/bin/ctags'
HOOKS=( ctags post-merge post-commit post-checkout post-rewrite )
HOOKS_DIR='.git/hooks'
TAGSFILE='.git/tags'

# Script:
DEBUG=1

install_hooks ()
{
if  [ $1 == "all" ] ; then
    HOOK_LIST=$HOOKS
else
    HOOK_LIST=$1
fi

for hook in ${HOOK_LIST}; do
    if [ $DEBUG ] ; then 
        echo $hook
    fi

    if [ hook == "ctags" ] ; then
        create_ctags
    else
        create_hk $hook
    fi
done
}


# code to go into other hook files:
create_hk ()
{
NAME=$1
echo "#!/bin/sh
#$HOOKS_DIR/ctags >/dev/null 2>&1 &
$HOOKS_DIR/ctags
" > $HOOKS_DIR/$NAME   

    
}

# code to go into ctags hook file:
create_ctags ()
{
NAME=ctags
echo "#!/bin/sh
rm -f ${TAGSFILE}
${CTAGS} --tag-relative -Rf ${TAGSFILE} --exclude=.git >/dev/null 2>&1 &
" > $HOOKS_DIR/$NAME   
}



# Main choice
case $1 in
    install)
        if [ $2 ] ; then
            echo "in2: $2"
            HOOK_NAME="$2"
        else
            HOOK_NAME="all"
        fi
        install_hooks $HOOK_NAME
    ;;

    -h|--help|*)
        usage
    ;;
esac

