# dotfiles

Install [stow](http://www.gnu.org/software/stow/manual/stow.html)
```
sudo apt-get install stow
```

```
git clone --recursive git@github.com:ssledz/dotfiles.git
```

## adding new module
```
cd dotfiles
git submodule add https://github.com/zsh-users/zsh-autosuggestions.git\
  zsh/.oh-my-zsh-custom/plugins/zsh-autosuggestions/
git add -A
git commit -m 'new module'
git push
```
