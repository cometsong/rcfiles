##### chdir func #####
# func to cd to another dir (or .), then cd to abspath, if exists. set OLDPWD to initial dir, not linked dir
cdp () { d=${1:-.}; local OLD2="$(pwd)"; cd "$d" && cd "$(pwd -P)" && export OLDPWD="$OLD2" || echo "does '$d' exist?"; };
