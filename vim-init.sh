#!/bin/bash

vim +PluginInstall +qall
cd ~/.vim/bundle/fzf && ./install --all
#brew install cmake python go nodejs
cd ~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer
