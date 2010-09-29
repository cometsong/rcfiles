#!/bin/bash
# CONFIG list of rcfiles for ln from home dir:
lnkRCs=(profile zshrc bash_profile vimrc vim)

read -p "
   This file will remove the startup files in your home dir (~) 
   and create symbolic links to the rcfiles replacements.
   Please enter the path in which the rcfiles repository is stored.
   [default is ~/code/rcfiles]:" \
     -r rc_path
RCPATH=${rc_path:=$HOME/code/rcfiles} #default value assigned if none entered

for LName in ${lnkRCs[@]} ; do {
  if (test -a $HOME/.$LName || test -h $HOME/.$LName); # if file or link exists
  then  rm -f $HOME/.$LName ;                      # rm ~/link
  fi

  echo "    Link to $LName...."
  echo "      $RCPATH/$LName ~/.$LName"
  ln -s $RCPATH/$LName $HOME/.$LName               # create new link to rcfile
  };
done


# Sed the RCPATH entries in the shrc files to find all the others
edRCs=(zshrc bash_profile profile)
#echo "rcpath: $RCPATH."
for fName in ${edRCs[@]} ; do {
  echo "    Editing filepath in $fName...."
  sed -e s\%RCPATH=.*%RCPATH=$RCPATH% -i '' $RCPATH/$fName
  };
done

#"Done"

