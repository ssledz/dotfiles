# Path to your oh-my-zsh installation.
  export ZSH=~/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="ssledz"
#ZSH_THEME="agnoster"
#ZSH_THEME="solarized-powerline"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/.oh-my-zsh-custom

[[ -z $ZSH_TMUX_AUTOSTART ]] && ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOQUIT=false
ZSH_TMUX_AUTOCONNECT=false


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#plugins=(git rbenv gitignore tmux ssledz-utils zsh-autosuggestions jenv)
plugins=(git rbenv gitignore tmux zsh-autosuggestions jenv kubectl)


# User configuration
#
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=1,bold"

# Any pattern that does not match is passed as a literal argument to the command (like in Bash)
setopt NO_NOMATCH

autoload zmv

if [ -f ~/.env_variables ]; then
    source ~/.env_variables
fi

source $ZSH/oh-my-zsh.sh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#

if [ -f ~/.aliases ]; then
    source ~/.aliases
fi

if [ -f ~/.zsh_aliases ]; then
    source ~/.zsh_aliases
fi

# Local config

if [ -f ~/.zshrc_local ]; then
    source ~/.zshrc_local
fi

[ -f ~/.sdkman/bin/sdkman-init.sh ] && source ~/.sdkman/bin/sdkman-init.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.ghcup/env ] && source ~/.ghcup/env
[ -f ~/.nix-profile/etc/profile.d/nix.sh ] && source ~/.nix-profile/etc/profile.d/nix.sh

if [[ $(command -v direnv) ]]; then
  eval "$(direnv hook zsh)"
fi




export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
