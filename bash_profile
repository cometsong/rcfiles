# .bash_profile

# multi-dotfile setup
source .sh_config              # load base config 

echo "Welcome to $HOSTNAME in bash shell"!

# set cmd prompt for bash shells 
# = user@host(underlined) pwd(green) \n time>
PS1='\e[0;37m\u @\e[4m\h\e[24m [\e[0;32m\w\e[m\e[0;37m]\n\e[m\t> '
