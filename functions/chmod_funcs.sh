##### chmod functions #####

# ug=r,o-rwx
chmod_ug_r() {
  find . -type d -exec chmod 550 {} \;
  find . -type f -exec chmod 440 {} \;
}
# group-writable, other-none
chmod_ug_rw() {
  find . -type d -exec chmod 770 {} \;
  find . -type f -exec chmod 660 {} \;
}
# group-writable
chmod_ugw_or() {
  find . -type d -exec chmod 775 {} \;
  find . -type f -exec chmod 664 {} \;
}
# not group-writable
chmod_uw_gor() {
  find . -type d -exec chmod 755 {} \;
  find . -type f -exec chmod 644 {} \;
}
