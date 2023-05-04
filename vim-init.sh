#!/bin/bash

vim +PluginInstall +qall
cd ~/.vim/bundle/fzf && ./install --all
cd ~/.vim/bundle/YouCompleteMe && ./install.py --clang-completer
