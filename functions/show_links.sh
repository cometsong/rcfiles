function show_links () {
    path="${1:-./}";
    ls -goli | \
    awk '$3>1 && match($2,"^-[r-]") {print $7,"("$3" links)"; system("find $path -inum "$1" 2>/dev/null| sed \"s/^/ - /\"")}'
}
#show_links $@
