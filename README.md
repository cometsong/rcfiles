## To use this 'rcfiles' project:

-----------------------------------------------------------------  
> **It can be installed via an included shell script: INSTALL.sh**  

-----------------------------------------------------------------  
To Install, simply clone the git repository to wherever you'd like to keep it.
Then cd to that dir, check/edit the Makefile, and run 'make'

This will delete all links/files that exist in your home dir (or other 
destination) and make new ones from the files in this repo.


**OR.........................................**  
If you prefer *Manual Installation* mode...
Just follow these old vague directions:

        ln -s ~/[rcfiles.git.dir]/zshrc ~/.zshrc
        ln -s ~/[rcfiles.git.dir]/bash_profile ~/.bash_profile
        for each and every file that you want there

Of course replacing "`[rcfiles.git.dir]`" with the actual directory you've cloned
this git repo into if you haven't just moved it to your home dir straight out.

**OR.........................................**  
If your prefer actual files instead of links, then just copy the desired files
to your `$HOME` directory.


One note: there's a file named '`my_aliases`' referring to a file with private
shortcuts, functions, etc. It's in gitignore, but it IS linked to, so if you
don't have it, then just rm the resulting link, or create a while new file of
excitement!

Smile,
    Cometsong
