#!/bin/bash

mkdir -p ~/.tmux/plugins
mkdir -p ~/.config
mkdir -p ~/.config/ranger
mkdir -p ~/.config/opencode
mkdir -p ~/.config/k9s
mkdir -p ~/.config/1Password/ssh/

stow -R -v -t ~/ git
stow -R -v -t ~/ tmux vim zsh
stow -R -v -t ~/.config/ranger ranger
stow -R -v -t ~/.config/opencode opencode
stow -R -v -t ~/.config/k9s k9s
stow -R -v -t ~/.config/1Password/ssh/ 1password
stow -R -v -t ~/ spacemacs
