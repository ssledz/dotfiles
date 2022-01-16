#!/bin/bash

conf_file=~/.dotfiles
default_profile=priv


profile() {
  local profile
  if [ -e $conf_file ]; then
    profile=$(cat $conf_file | grep -v '^#' | grep '^profile=' | cut -d '=' -f 2)
  fi
  [[ -z $profile ]] && echo $default_profile || echo $profile
}

mkdir -p ~/acpi
mkdir -p ~/utils
mkdir -p ~/.tmux/plugins
mkdir -p ~/.urxvt
mkdir -p ~/.config
mkdir -p ~/.config/ranger
mkdir -p ~/.config/awesome
mkdir -p ~/.mcabber

profile=$(profile)

echo "Active profile : $profile"

stow --override=* -R -v -t ~/ -d git $profile
stow --override=* -R -v -t ~/ -d xdg $profile
stow -R -v -t ~/ bash common functions tmux vim zsh x spacemacs
stow -R -v -t ~/.config/awesome awesome
stow -R -v -t ~/.mcabber mcabber
stow -R -v -t ~/ octave
stow -R -v -t ~/ misc
stow -R -v -t ~/.config/ranger ranger
stow -R -v -t ~/acpi acpi
stow -R -v -t ~/utils utils
stow -R -v -t ~/.urxvt urxvt
stow -R -v -t ~/.config i3wm

vim +PluginInstall +qall
cd ~/.vim/bundle/fzf && ./install --all
cd ~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer
