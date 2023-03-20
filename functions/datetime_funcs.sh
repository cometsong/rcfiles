##### datestamp functions #####
get_datestamp()     ( date +"${*:-"%Y-%m-%d %H:%M:%S"}"; )
get_datestamp_tz()  ( get_datestamp "%Y-%m-%d %H:%M:%S%z"; )
get_datestamp_ymd() ( get_datestamp "%Y-%m-%d"; )

