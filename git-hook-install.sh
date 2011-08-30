#!/bin/bash - 
#===============================================================================
#          FILE:  git-hook-install.sh
#   DESCRIPTION:  Installs several git hook scripts to run ctags after each repo update
#       OPTIONS:  ---
#  REQUIREMENTS:  Exuberant ctags
#        AUTHOR: B. Leopold (jaminwebdesign at gmail dot com)
#       CREATED: 2011-08-30 16:38:15+0200
#===============================================================================

set -o nounset                              # Treat unset variables as an error


#!/bin/sh
CTAGS='/usr/local/bin/ctags'
HOOKS=%w{ post-merge post-commit post-checkout post-rewrite }
HOOKS_DIR='.git/hooks'
TAGSFILE='.git/tags'



install_hooks ()
{
    
    for hook in ${HOOKS}; do
    done


    # code to go into ctags hook file:
#    #!/bin/sh
#    rm -f ${TAGSFILE}
#    ${CTAGS} --tag-relative -Rf ${TAGSFILE} --exclude=.git

    # code to go into other hook files:
#    #!/bin/sh
#    .git/hooks/ctags >/dev/null 2>&1 &

# TODO : test whether above dev null output redirect can be placed into ctags hook file

}

usage ()
{
    echo
    echo "Usage: $0 [install [<hook_name>]] [-h|--help]"
    echo "  defaul installation is All hooks"
}


case $1 in
    install)
        install_hooks $2
    ;;

    -h|--help|*)
        usage
    ;;
esac

