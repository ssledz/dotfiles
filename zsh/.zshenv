ZSH_CUSTOM=$HOME/.oh-my-zsh-custom

#Load all built in libs
for my_lib ($ZSH_CUSTOM/plugins/ssledz-utils/builtin-lib/*); do
  source $my_lib
done

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
