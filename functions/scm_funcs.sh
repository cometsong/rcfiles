##### git #####
## Also see ~/.gitconfig ##
alias g="git";

gfm() {
  git fetch $*;
  git merge FETCH_HEAD;
}
gfms() {
  gfm "$@";
  git submodule init;
  git_sub_pull;
}
git_sub_pull() {
  REPO=${1:-'origin'};
  BRANCH=${2:-'master'};
  git submodule foreach --recursive '
    git checkout $BRANCH;
    git pull $REPO $BRANCH;
    cd $toplevel;
    git submodule sync -- $path;
    cd $path;';
}
gbranch() (
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/';
)

# queries config for all remote repos, pushes git_current_branch to all
gpa() {
    REMOTES="$(git remote | uniq)";
    branch=$(gbranch);
    for R in ${REMOTES}; do
        echo "Pushing '${branch}' to '${R}'";
        echo git push --tags ${R} ${branch};
    done;
}

gshow() {
  # Summarize git details:
  #   Remotes, Branches, Status, Logs (-$1), Tags
  # unset/reset local core.pager (avoid 'less')
  local msgs="${1:-11}";
  local IFS=$'\n';
  local orig_pager="$(git config --local --get core.pager)";
  local bRed=$(tput setab 1);
  local Norm=$(tput sgr0);
  declare -A sections=(
     [Remotes]='git remote -v'
      [Status]='git status --short --branch'
         [Log]="git log --oneline --decorate --date=short -${msgs}"
    [Branches]='git branch -avv'
        [Tags]='git describe --tags --long'
  ) && \
  git config --local core.pager '' && \
  for sec in ${!sections[*]}; do
    printf "${bRed} == %b == ${Norm}\n" "$sec";
    eval "${sections[$sec]}" 2>&1;
  done && \
  git config --local core.pager "$orig_pager";
}
