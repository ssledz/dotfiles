#!/bin/bash

mkdir -p ~/.tmux/plugins
mkdir -p ~/.urxvt
mkdir -p ~/.config
mkdir -p ~/.config/ranger
mkdir -p ~/.config/opecode

stow -R -v -t ~/ git
#stow -R -v -t ~/ emacs
stow -R -v -t ~/ tmux vim zsh
stow -R -v -t ~/.config/ranger ranger
stow -R -v -t ~/.config/opencode opencode
