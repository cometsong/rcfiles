# check command funcs
chk_cmd()     { command -V "${1?Check which cmd?}"; }
chk_cmd_out() { chk_cmd "$1" 2>/dev/null; }
chk_cmd_qt()  { chk_cmd "$1" >/dev/null 2>&1; }
