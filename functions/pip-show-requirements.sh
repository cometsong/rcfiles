pip_show_reqs() {
  pip=${1:-pip}
  echo "Showing Requirements for 'pip' installations"
  for P in $($pip list | tail -n +3 | awk '{print $1}'); do
      printf '%-25s : ' "$P";
      $pip show $P | grep "^Requires" | cut -c10-100;
  done
};

pip3_show_reqs() { pip_show_reqs 'pip3'; };
#pip3_show_reqs

pip_upgrade () {
    pip=${1:-pip};
    up_opts="--upgrade-strategy eager --progress-bar on";
    ${pip} list -o &&      \
    echo "Beginning upgrades of outdated packages..." && \
    ${pip} list -o         \
        | tail -n +3       \
        | awk '{print $1}' \
        | xargs -I{}       \
            ${pip} install -U ${up_opts} {}
}
alias pip3_upgrade="pip_upgrade pip3"
