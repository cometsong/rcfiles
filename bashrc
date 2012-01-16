# ---------------------------------------------------------------------------- #
#                           bashrc of JaminOne rcfiles                         #
# ---------------------------------------------------------------------------- #
# when bash starts non-login, run the profle anyway.
if [ -n "$PS1" ]; then
	[ -r $HOME/.bash_profile ] && . $HOME/.bash_profile
fi

