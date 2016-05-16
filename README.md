# dotfiles

Install [stow](http://www.gnu.org/software/stow/manual/stow.html)
```
sudo apt-get install stow
```

Link all dotfiles to home directory
```
git clone https://github.com/ssledz/dotfiles.git
cd dotfiles
stow -S -v -t ~/ bash common functions git tmux vim zsh x
```

To unlink
```
cd dotfiles
stow -D -v -t ~/ bash common functions git tmux vim zsh x
```

##Set up [Vundle](https://github.com/VundleVim/Vundle.vim)
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
