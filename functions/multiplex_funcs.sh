# from screen-list.sh (more comments for readability in there)
sclists() {
    LL=$(screen -ls \
        | grep "^[[:space:]][0-9]." \
        | sed "s'\([0-9]*\)\.\([-_~.A-Za-z]*\).*\(..tached\).*'\2 \1 \3'" \
        | sort 
        );
    if [[ "x$LL" != "x" ]]; then
        echo "Screen sessions"
        echo "name pid status" \
             "------------ ------ ----------" \
             "$LL" \
            | xargs printf "%-12s %-6s %-10s\n";
    else 
        echo "  No screen sessions running."
    fi
}

# from tmux-list.sh (more comments for readability in there)
tmlists() {
    local CMD="tmux ls -F '#{session_name} #{session_windows} #{?session_attached,Attached,Detached}'"
    local LL=$(eval $CMD 2> /dev/null | sort)

    if [[  "x$LL" != "x" ]]; then
        echo "tmux sessions:"
        echo "name wins status" \
             "------------ ------ ----------" \
             "$LL" \
            | xargs printf "%-12s %-6s %-10s\n";
    else 
        echo "  No tmux sessions running."
    fi
}

listawkout() {
    # expects a string with three args to be split on whitespace
    if [ "$*" ]; then
        echo "$*" |\
        awk '{printf("  %-12s %-6s %-10s\n", $1, $2, $3)}'
    fi
}
