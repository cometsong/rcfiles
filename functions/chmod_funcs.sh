#!/usr/bin/env sh

##### chmod functions #####
# ug=r,o-rwx
function chmod-ug-r() {
  find . -type d -exec chmod 550 {} \;
  find . -type f -exec chmod 440 {} \;
}
# group-writable, other-none
function chmod-ug-rw() {
  find . -type d -exec chmod 770 {} \;
  find . -type f -exec chmod 660 {} \;
}
# group-writable
function chmod-ugw-or() {
  find . -type d -exec chmod 775 {} \;
  find . -type f -exec chmod 664 {} \;
}
# not group-writable
function chmod-uw-gor() {
  find . -type d -exec chmod 755 {} \;
  find . -type f -exec chmod 644 {} \;
}
