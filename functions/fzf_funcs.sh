#################################
#         fuzzy functions       #
#################################
# Many thanks to fzf community! #
#################################

# fcd - cd to fuzzily selected directory
fcd( ) {
  local dir;
  dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m) \
  && cd "$dir" || return
  }

# fcd - cd to fuzzily selected directory (search includes hidden dirs)
fcda( ) {
  local dir;
  dir=$(find ${1:-.} -path '*/\.*' -prune \
        -o -type d -print 2> /dev/null | fzf +m) \
  && cd "$dir" || return
  }

# cdfz - cd into the directory of the fuzzily selected file
cdfz( ) {
  local file dir;
  file=$(fzf +m -q "$1") && \
  dir=$(dirname "$file") && \
  cd "$dir" || return
}

# vimz - load fuzzily selected files into vim editor
vimz( ) {
  local files="$(fzf -m)";
  [ -n "$files" ] && vim -- $files;
}

