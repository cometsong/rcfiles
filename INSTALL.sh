#!/bin/bash

read -p "
  ==============================================================
  IMPORTANT!!!
   This file will REMOVE the startup files in your home dir (~) 
   and create links to the rcfiles replacements (symbolic if dir).

  ==============================================================
  ALSO!!!
   Your default git config user.name and user.email will be set 
   according to the values YOU HAVE SET in \"git_user.sh\"
   
  ==============================================================
   Please enter the path in which the rcfiles repository is stored.
   [default is $HOME/code/rcfiles]:" \
     -r rc_path
RCPATH=${rc_path:=$HOME/code/rcfiles} #default value assigned if none entered

# CHANGE THESE VALUES in git_user.sh DEPENDING ON YOUR OS/LOCATION!!!
#   Git Config User.Name and User.Email
source $RCPATH/git_user.sh


# List of rcfiles for ln from git repo dir to home dir:
lnkRCs=(rcprofile bash_profile zshrc bashrc bash_completion
        toprc screenrc tmux.conf
        vimrc gvimrc vim 
        gitconfig gitignore_global git_template_global
        perltidyrc pythonrc.py pylintrc inputrc
        )

for LName in ${lnkRCs[@]} ; do {
  if (test -d $LName)                             # if it's a dir
    then  rm -rf $HOME/.$LName ;                  # rm ~/dir
          ln -sf $RCPATH/$LName $HOME/.$LName     # create new link to dir
  else 
    if (test -e $LName);                              # if file exists
        then  rm -f $HOME/.$LName ;                   # rm ~/link
              ln -f $RCPATH/$LName $HOME/.$LName      # create new link to file
    fi
  fi
  echo "    Link to $LName....   $RCPATH/$LName"
  };
done

# create file defining the RCPATH var for the config script to source
echo "RCPATH=${RCPATH}" > $HOME/.rcpath_env

# link all files in $RCPATH/bin to $HOME/bin
#   create dir if does not exist
if [[ ! -d $HOME/bin ]] ; then
    mkdir $HOME/bin
fi

BINS=$(ls -1 $RCPATH/bin)
for B in $BINS; do
    if (test -a $HOME/.$B || test -h $HOME/.$B);    # if file or link exists
    then  rm -f $HOME/.$B ;                         # rm ~/link
    fi

    echo "    Link to $HOME/bin/$B...."
    ln -f $RCPATH/bin/$B $HOME/bin/$B               # create new link to rcfile
done


#"Done"

