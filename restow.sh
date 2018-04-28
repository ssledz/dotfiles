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
mkdir -p ~/.config/i3


profile=$(profile)

echo "Active profile : $profile"

stow -R -v -t ~/ -d git $profile
stow -R -v -t ~/ -d xdg $profile
stow -R -v -t ~/ bash common functions tmux vim zsh x
stow -R -v -t ~/.config/awesome awesome
stow -R -v -t ~/.mcabber mcabber
stow -R -v -t ~/ octave
stow -R -v -t ~/ misc
stow -R -v -t ~/.config/ranger ranger
stow -R -v -t ~/acpi acpi
stow -R -v -t ~/utils utils
stow -R -v -t ~/.urxvt urxvt
stow -R -v -t ~/.config/i3/ i3wm
