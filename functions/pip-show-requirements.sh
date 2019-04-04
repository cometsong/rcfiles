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
