function calc () {
    echo "scale=5;$@" | bc -l
}
