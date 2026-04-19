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

## Install kubernetes tools (kubectl)

* https://kubernetes.io/docs/tasks/tools/

```bash
brew install kubectl
```

## Install k9s

* https://k9scli.io/topics/install/

```bash
brew install derailed/k9s/k9s
```

## Install jdk & scala

Install [jenv](https://github.com/jenv/jenv)

```bash
brew install jenv
```

Install [sdkman](https://sdkman.io/)

`SDKMAN` requires Bash 4 or higher

```bash
brew install bash
```

```bash
curl -s "https://get.sdkman.io" | bash
```

Install jdk

```
sdk install java 17.0.18-tem
sdk install java 21.0.10-tem
jenv add /Users/slawomir.sledz/.sdkman/candidates/java/17.0.18-tem
jenv add /Users/slawomir.sledz/.sdkman/candidates/java/21.0.10-tem
jenv global 21
jenv rehash
```

Install scala

```bash
sdk install scala 2.13.18
sdk install sbt 1.12.9
brew install coursier/formulas/coursier
sdk install scalacli
scala-cli install-completions
cs install scalafmt
```

Install metals

* [Installation instruction](https://gist.github.com/ssledz/276085b2f1f29868d4e423136ed94de3)

```bash
cd ~/bin

coursier bootstrap \
  --java-opt -XX:+UseG1GC \
  --java-opt -XX:+UseStringDeduplication \
  --java-opt -Xss4m \
  --java-opt -Xms100m \
  org.scalameta:metals_2.13:1.6.6 -o metals -f

chmod +x metals
```

Install jetbrains toolbox

```bash
brew install --cask jetbrains-toolbox --appdir=/Users/slawomir.sledz/bin
```

## Install nodejs

Install [nvm](https://github.com/nvm-sh/nvm)

```bash
mkdir ~/.nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.4/install.sh | bash
```

Install nodejs

```bash
nvm install 24
nvm use 24
```

Install [bun](https://bun.com/get)

```bash
npm install -g bun
```


## Install opencode

Before install nodejs & bun

```bash
brew install anomalyco/tap/opencode
```

## Install obsidian

```bash
brew install --cask obsidian --appdir=/Users/slawomir.sledz/bin
```

## Install azure-cli (az)

```bash
brew update && brew install azure-cli
```
