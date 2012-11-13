#!/bin/bash

# CHANGE THESE DEFAULTS DEPENDING ON YOUR OS/LOCATION!!!
# Git Config User.Name and User.Email


#  for UKM unix boxes
if [[ `uname -n` == "ToothAndNails" ]] || [[ `uname -n` == "NGS-Anal" ]] || [[ `uname -n` == "palma001" ]]; then
  GITUSERNAME="cometsong"
  GITEMAIL=bLeopold.NOSPAM@uni-muenster.de
fi

# for MacBook Laptop
if [[ `uname -n` == "JuniorMint.local" ]] | [[ `uname -n` =~ ".alicedsl.de" ]]; then
  GITUSERNAME="cometsong"
  GITEMAIL=benjamin.NOSPAM@cometsong.net
fi


if [[ -n $GITUSERNAME ]]; then
  git config user.name "$GITUSERNAME"
  unset GITUSERNAME
fi
if [[ -n $GITEMAIL ]]; then
  git config user.email "$GITEMAIL"
  unset GITEMAIL
fi


