#!/usr/bin/env sh

##### git ##### 
## Also see ~/.gitconfig ##
alias g="git"

function gfm() {
  git fetch $*
  git merge FETCH_HEAD
}
function gfms() {
  git fetch
  git merge FETCH_HEAD
  git submodule init
  git-sub-pull
}
function git-sub-pull() {
  REPO=${1:-origin}
  BRANCH=${2:-master}
  git submodule foreach --recursive '
    git checkout $BRANCH;
    git pull $REPO $BRANCH;
    cd $toplevel;
    git submodule sync -- $path;
    cd $path;'
}
function gbranch() {
  current_branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
}
function gpo() {
  # pushes the current branch; whatever that is
  gbranch
  git push origin $current_branch
}
function guo() {
  # pulls the current branch; whatever that is
  gbranch
  git pull origin $current_branch
}
function gpom() {
  git push origin master
}
function guom() {
  git pull origin master
}

# queries config for all remote repos, pushes master to all
function gpam() { 
    REMOTES=( $(git remote) )
    for R in $REMOTES; do 
        echo Pushing to $R
        git push --tags $R master
    done
}

# queries config for all remote repos, pushes current_branch to all
function gpab() { 
    REMOTES=`git remote | uniq`
    gbranch
    for R in $REMOTES; do 
        echo Pushing \"$current_branch\" to \"$R\"
        git push --tags $R $current_branch
    done
}
