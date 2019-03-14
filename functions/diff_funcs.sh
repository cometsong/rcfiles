diffy() { diff -y -W150 --left-column $@ ; };
diffly() { diffy $@ | less; };
diffsy() { diffy --suppress-common-lines $@; }
