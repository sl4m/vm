function ssh_key_for {
  curl -i https://api.github.com/users/${1}/keys
}
