# .bash_profile

# Set path to rcfiles git repository
RCPATH=/home/benjamin/code/rcfiles
# multi-dotfile setup
source $RCPATH/profile          # load base profile

echo "Welcome to $HOSTNAME in bash shell"!

# set cmd prompt for bash shells 
# = user@host(underlined) pwd(green) \n time>
PS1='\e[0;37m\u @\e[4m\h\e[24m [\e[0;32m\w\e[m\e[0;37m]\n\e[m\t> '
