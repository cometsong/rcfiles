##### git ##### 
## Also see ~/.gitconfig ##
alias g="git"

gfm() {
  git fetch $*
  git merge FETCH_HEAD
}
gfms() {
  git fetch
  git merge FETCH_HEAD
  git submodule init
  git-sub-pull
}
git-sub-pull() {
  REPO=${1:-origin}
  BRANCH=${2:-master}
  git submodule foreach --recursive '
    git checkout $BRANCH;
    git pull $REPO $BRANCH;
    cd $toplevel;
    git submodule sync -- $path;
    cd $path;'
}
gbranch() {
  current_branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
}
gpo() {
  # pushes the current branch; whatever that is
  gbranch
  git push origin $current_branch
}
guo() {
  # pulls the current branch; whatever that is
  gbranch
  git pull origin $current_branch
}
gpom() {
  git push origin master
}
guom() {
  git pull origin master
}

# queries config for all remote repos, pushes master to all
gpam() { 
    REMOTES=( $(git remote) )
    for R in $REMOTES; do 
        echo Pushing to $R
        git push --tags $R master
    done
}

# queries config for all remote repos, pushes current_branch to all
gpab() { 
    REMOTES=`git remote | uniq`
    gbranch
    for R in $REMOTES; do 
        echo Pushing \"$current_branch\" to \"$R\"
        git push --tags $R $current_branch
    done
}

gshow( ) {
  # Summarize git details:
  #   Remotes, Branches, Status, Logs (-$1), Tags
  # unset/reset local core.pager (avoid 'less')
  msgs="${1:-11}"
  orig_pager="$(git config --local --get core.pager)" && \
  git config core.pager '';
  echo "${b_Rd} == Remotes == ${NORM}" \
    && git remote -v;
  echo "${b_Rd} == Branches == ${NORM}" \
    && git branch -avv;
  echo "${b_Rd} == Status == ${NORM}" \
    && git status --short --branch;
  echo "${b_Rd} == Log == ${NORM}" \
    && git log --oneline --decorate --date=short -$msgs && \
  echo "${b_Rd} == Tags == ${NORM}" \
    && git describe --tags --long && \
  git config --local core.pager "$orig_pager"
}

