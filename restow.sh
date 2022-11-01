#!/bin/bash

mkdir -p ~/.tmux/plugins
mkdir -p ~/.urxvt
mkdir -p ~/.config
mkdir -p ~/.config/ranger

stow -R -v -t ~/ git 
stow -R -v -t ~/ tmux vim zsh x
stow -R -v -t ~/.config/ranger ranger
stow -R -v -t ~/.urxvt urxvt

#vim +PluginInstall +qall
#cd ~/.vim/bundle/fzf && ./install --all
#cd ~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer
