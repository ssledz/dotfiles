ssu_fs_crypt() {

  local prog_name=$0

  _ssu_fs_crypt_usage() {
    echo -n "$prog_name [m|mount|u|unmount]"
    echo " - either mounts or unmounts encrypted file system"
  }

  local encrypted_dir=$HOME/Dropbox/.crypt
  local decrytped_dir=$HOME/crypt

  if [ -z $1 ]
  then
    _ssu_fs_crypt_usage
    return 1
  fi

  case "$1" in
    "m" | "mount" )
      mkdir -p ${decrytped_dir}
      [[ ! $(ls -A ${decrytped_dir} | wc -l) == 0 ]] && echo "${decrytped_dir} is not Empty" && return 2
      encfs ${encrypted_dir} ${decrytped_dir}
      echo "Encrypted filesystem now mounted"
      ;;
    "u" | "unmount" )
      fusermount -u ${decrytped_dir}
      echo "Encrypted filesystem has been unmounted"
      ;;
    * )
      _ssu_fs_crypt_usage
      ;;
  esac
}
