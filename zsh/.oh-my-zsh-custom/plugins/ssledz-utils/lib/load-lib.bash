ssu_load_lib() {

  if [[ -e $ZSH_CUSTOM/plugins/ssledz-utils/lib/$1 ]] ; then
    source $ZSH_CUSTOM/plugins/ssledz-utils/lib/$1
  else
    local sufix=${SHELL##/usr/bin/}
    source $ZSH_CUSTOM/plugins/ssledz-utils/lib/$1.$sufix
  fi
}

