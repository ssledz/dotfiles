#!/bin/bash

mkdir -p ~/acpi
mkdir -p ~/utils
mkdir -p ~/.tmux/plugins
mkdir -p ~/.urxvt
mkdir -p ~/.config
mkdir -p ~/.config/ranger
mkdir -p ~/.config/awesome
mkdir -p ~/.mcabber

stow -R -v -t ~/ git
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
stow -R -v -t ~/ emacs
