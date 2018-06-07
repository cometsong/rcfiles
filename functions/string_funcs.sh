##### string functions #####
# Warning! Here be bashisms...


# does string 1 contain string 2 ?
# from https://stackoverflow.com/a/18441709/1600630
stringContains() { [[ "$1" == *"$2"* ]] && echo 1; }

# does string1 end with str 2 ?
endswith() { [[ "$1" == *"$2" ]] && echo 1; }

# does string1 start with str 2 ?
startswith() { [[ "$1" == "$2"* ]] && echo 1; }


## tests!
#str1="foodie" && echo "str1: $str1"
#str2="foo"    && echo "str2: $str2"
#str3="odie"   && echo "str3: $str3"
#str4="foods"  && echo "str4: $str4"
#echo

#for str in $str1 $str2 $str3 $str4; do
#    [ $(stringContains "$str1" "$str") ] \
#        && echo "'$str1' contains '$str'" \
#        || echo "'$str1' does NOT contain '$str'"
#    [ $(startswith "$str1" "$str") ] \
#        && echo "'$str1' starts with '$str'" \
#        || echo "'$str1' does NOT start with '$str'"
#    [ $(endswith "$str1" "$str") ] \
#        && echo "'$str1' ends with '$str'" \
#        || echo "'$str1' does NOT end with '$str'"
#    echo
#done
