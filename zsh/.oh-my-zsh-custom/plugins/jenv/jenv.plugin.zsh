function jenv_prompt_info() {
  if [[ "$(_jenv_available)" == "true" ]] ; then
    echo $(_jenv_colour_prefix)"java:(%{$fg[red]%}"$(jenv version-name)$(_jenv_colour_prefix)")%{$reset_color%} "
  else
    echo ""
  fi
}

function _jenv_available() {
  if [ "$(command jenv 2>/dev/null)" -eq 0 ] ; then
    echo "true"
  else
    echo "false"
  fi
}

function _jenv_colour_prefix() {
  echo "%{$fg_bold[blue]%}"
}

JENV_FOUND=0

function _jenv_init() {

  local -a jenv_dirs=("$HOME/.jenv" "/usr/local/jenv")

  for jenv_dir in "${jenv_dirs[@]}" ; do
    if [ -s "${jenv_dir}/bin/jenv" -a $JENV_FOUND -eq 0 ] ; then
      JENV_FOUND=1
      export PATH=${jenv_dir}/bin:$PATH
      eval "$(jenv init - zsh)"
    fi
  done

}

_jenv_init

[[ "$(_jenv_available)" == "true" ]] \
  && JAVA_HOME=$(jenv javahome) \
  && source $ZSH_CUSTOM/plugins/jenv/jenv_functions.zsh
