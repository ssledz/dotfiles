# set default java
# export PATH="/usr/local/opt/scala@2.13/bin:/opt/homebrew/opt/openjdk@11/bin:$PATH"

export PATH="/usr/local/opt/scala@2.13/bin:/usr/local/opt/openjdk@11/bin:$PATH"

export PATH="$HOME/bin/homebrew/bin:$HOME/bin:$HOME/.emacs.d/bin:$HOME/.aiken/bin:$HOME/.cabal/bin:$HOME/bin:$HOME/.local/bin:$PATH"

export K9SCONFIG="$HOME/.config/k9s"

export XDG_CONFIG_HOME="$HOME/.config"

[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
