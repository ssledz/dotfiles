# dotfiles

Install [stow](https://formulae.brew.sh/formula/stow)
```
brew install stow
```

```
git clone --recursive git@github.com:ssledz/dotfiles.git
```

```
git submodule update --init --recursive
```

## Adding new module
```
cd dotfiles
git submodule add https://github.com/zsh-users/zsh-autosuggestions.git\
  zsh/.oh-my-zsh-custom/plugins/zsh-autosuggestions/
git add -A
git commit -m 'new module'
git push
```

## Setup tmux

```bash
brew install tmux
```

## Setup powerline fonts

**manual**

```bash
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd .. && rm -rf fonts
``**

**homebrew**

```bash
brew install --cask font-meslo-nerd-font
Gbrew install --cask font-hack-nerd-font
brew install --cask font-source-code-pro-nerd-font
```

Next set powerline fonts in iterm

## Setup iterm

* Download [solarized theme](https://raw.githubusercontent.com/mbadolato/iTerm2-Color-Schemes/master/schemes/iTerm2%20Solarized%20Dark.itermcolors)
from [Iterm2-color-schemes](https://iterm2colorschemes.com/)
* Import theme to iterm
* Set theme for a default profile

## Setup spacemacs

```bash
brew install --cask emacs --appdir=/Users/slawomir.sledz/bin
```

```bash
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
```

Install Fira Code fonts

```bash
brew install font-fira-code
```


## Setup vim

```bash
brew install cmake python go nodejs
./vim-init.sh
```
