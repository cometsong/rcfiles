### bash-it init enables ###
if ! command -v bash-it >/dev/null 2>&1; then
  echo >&2 "NOTE: bash-it is not installed!"
  exit 1
fi

bashit_enable() {
  ## presumes name of list is in: plugin, completion, alias
  ## Requires Bash v4.3+ for 'declare -n' for use with array
  declare -l arg="$1";
  declare -n list="$arg";
  printf "Enabling bash-it '$arg's\n"
  bash-it enable $arg ${list[*]};
}

declare -a plugin=(
  base 
  alias-completion 
  dirs 
  extract 
  fasd 
  fzf 
  git 
  go 
  history 
  history-search 
  history-substring-search 
  less-pretty-cat 
  man 
  node 
  osx 
  postgres 
  projects 
  python 
  ssh 
  tmux 
)

declare -a completion=(
  bash-it
  brew 
  defaults 
  dirs 
  django 
  export 
  git 
  go 
  makefile 
  npm 
  pew 
  pip3 
  projects 
  ssh 
  system 
  tmux 
)

declare -a alias=(
  bash-it
  curl
  git
  homebrew
  homebrew-cask
  node
  npm
  osx
)

for item in \
  plugin \
  completion \
  alias \
; do 
bashit_enable $item
done
