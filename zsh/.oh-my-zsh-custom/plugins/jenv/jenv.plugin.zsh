function jenv_prompt_info() {
  echo $(colour_prefix)"java:(%{$fg[red]%}"$(jenv version-name)$(colour_prefix)")%{$reset_color%} "
}

function colour_prefix() {
  echo "%{$fg_bold[blue]%}"
}
