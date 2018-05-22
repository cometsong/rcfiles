# based on cmdlinefu tip
weather() { curl -s "http://www.wunderground.com/q/zmw:${1?"Weather for which zip code?"}.1.99999" | grep "og:title" | cut -d\" -f4 | sed "s/&deg;/ degrees F/"; }

