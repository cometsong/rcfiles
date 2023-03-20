# Postgres admin query functions  NB: contains 'bashisms'

run_postgres_query( ) {
  local usage="USAGE: $FUNCNAME <user> <db> <sqlcommand>";
  [[ $1 =~ \-h ]]  && { printf '%s\n' "${usage}" && return 0; }
  [[ ! $# -ge 3 ]] && { printf '%s\n\t%s\n'
    "$FUNCNAME ERROR only $# args: '$*'" "${usage}" && return 1; }
  local username="${1}" && shift # && echo "username: $username"
  local database="${1}" && shift # && echo "database: $database"
  local command="${@}"           # && echo "command: $command"
  psql -U $username -d $database --command="${command}" && return 0;
}

run_postgres_admin_query( ) {
  local usage="USAGE: $FUNCNAME <sqlcommand>\nNote: db=postgres"
  [[ $1 =~ \-h ]] && { printf '%s\n' "${usage}" && return 0; }
  run_postgres_query ${USER} postgres ${*};
}

pgkillsession( ) {
[ -n "$1" ] || { echo "pg to kill what session pid? (Run 'pgsessions' if unsure.)" && return 1; }
  declare -i pid="$1";
  run_postgres_admin_query "select pg_terminate_backend(pid) from pg_stat_activity where pid="$pid";"
}

alias pgsessions="run_postgres_admin_query select pid, usename as username, datname as database_name, client_addr, application_name, backend_start, state, state_change from pg_stat_activity order by backend_start;"
alias pgusers="run_postgres_admin_query select usesysid as user_id, usename as username, usesuper as is_superuser, passwd as password_md5, valuntil as password_expiration from pg_shadow order by usename;"
#alias pgdbs="run_postgres_admin_query 'select oid as database_id, datname as database_name, datallowconn as allow_connect, datconnlimit as connection_limit from pg_database order by oid;'"
alias pgdbs="psql -l"

#run_postgres_query --help
#run_postgres_query foo bar   # test too few args
