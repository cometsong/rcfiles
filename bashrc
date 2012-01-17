# ---------------------------------------------------------------------------- #
#                           bashrc of JaminOne rcfiles                         #
# ---------------------------------------------------------------------------- #
if [  -f /etc/bashrc ]; then
    . /etc/bashrc
fi
        
# when bash starts non-login, run the profle anyway.
if [ -n "$PS1" ]; then
	[ -r $HOME/.sh_config ] && . $HOME/.sh_config
fi

