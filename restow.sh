#!/bin/bash

mkdir -p ~/.tmux/plugins
mkdir -p ~/.urxvt
mkdir -p ~/.config
mkdir -p ~/.config/ranger
mkdir -p ~/.config/opencode/commands
mkdir -p ~/.config/opencode/skills

stow -R -v -t ~/ git
stow -R -v -t ~/ tmux vim zsh
stow -R -v -t ~/.config/ranger ranger
stow -R -v -d opencode -t ~/.config/opencode/commands commands
stow -R -v -d opencode -t ~/.config/opencode/skills skills
stow -R -v -t ~/ spacemacs
