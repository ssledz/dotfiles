#!/bin/bash

mkdir -p ~/.tmux/plugins
mkdir -p ~/.urxvt
mkdir -p ~/.config
mkdir -p ~/.config/ranger

stow -R -v -t ~/ git
stow -R -v -t ~/ emacs
stow -R -v -t ~/ tmux vim zsh
stow -R -v -t ~/.config/ranger ranger
stow -R -v -t ~/.urxvt urxvt
