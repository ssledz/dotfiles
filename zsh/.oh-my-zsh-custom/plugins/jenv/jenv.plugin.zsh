jenv_prompt_info() {
  if [[ "$(_jenv_available)" == "true" ]] ; then
    echo $(_jenv_colour_prefix)"java:(%{$fg[red]%}"$(jenv version-name)$(_jenv_colour_prefix)")%{$reset_color%} "
  else
    echo ""
  fi
}

_jenv_available() {
  if [ "$(command jenv 2>/dev/null)" -eq 0 ] ; then
    echo "true"
  else
    echo "false"
  fi
}

_jenv_colour_prefix() {
  echo "%{$fg_bold[blue]%}"
}

local -x jenv_bin

_jenv_init() {
  local -a jenv_dirs=("$HOME/.jenv" "/usr/local/jenv")
  local jenv_found=0

  for jenv_dir in "${jenv_dirs[@]}" ; do
    if [ -s ${jenv_dir}/bin/jenv -a $jenv_found -eq 0 ] ; then
      jenv_found=1
      jenv_bin=${jenv_dir}/bin
      export PATH=${jenv_bin}:$PATH
      #set shell to zzsh to prevent embedded completion for jenv
      #eval "$(jenv init - zzsh)"
      eval "$(jenv init -)"
    fi
  done
}

_jenv_init \
  && [[ "$(_jenv_available)" == "true" ]] \
  && export JAVA_HOME=$($jenv_bin/jenv javahome) \
  && source $ZSH_CUSTOM/plugins/jenv/jenv_functions.zsh

