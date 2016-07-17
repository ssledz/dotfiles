ssu_cred_get_file() {
  if [[ "x$1" == "x" ]] ; then
    echo ".cred"
  else
    echo $1
  fi
}
ssu_cred_get_username() {
  local credential_file=$(ssu_cred_get_file $*)
  local user=$(cat $credential_file | head -1)
  echo $user
}

ssu_cred_get_password() {
  local credential_file=$(ssu_cred_get_file $*)
  local user_password=$(cat $credential_file | tail -1)
  echo $user_password
}

ssu_cred_file_exist() {
  local credential_file=$(ssu_cred_get_file $*)
  if [[ -r $credential_file ]] ; then
    echo "yes"
  else
    echo "no"
  fi
}

ssu_cred_read() {

  local -x credential_file=$(ssu_cred_get_file $*)
  local sleep_timeout=10

  echo -n 'username: '
  read user_name
  echo -n 'password: '
  read user_password
  echo -n "Valid for [enter for default=${sleep_timeout}s]: "
  read timeout

  echo $user_name > $credential_file
  echo $user_password >> $credential_file

  [[ "x$timeout" == "x" ]] && timeout=$sleep_timeout

  echo "Credentials saved in $credential_file and are valid for $timeout s"

  (sleep $timeout; rm $credential_file) &
}



