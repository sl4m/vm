function pg_terminate() {
  psql -d $1 -c "SELECT pg_terminate_backend(pid) FROM pg_stat_activity WHERE pid <> pg_backend_pid() AND datname = '$1'"
}
