function psgrep() {
    CMD=${1?'        pgrep for which cmd-re?'};
    pgrep_opts='-fi'
    if [ -n "$(pgrep ${pgrep_opts} $CMD)" ]; then
        ps $(pgrep ${pgrep_opts} $CMD);
    else
        echo "No pgrep's found";
    fi;
}
