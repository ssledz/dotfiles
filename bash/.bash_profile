[ -r ~/.profile ] && . ~/.profile             # set up environment, once, Bourne-sh syntax only.
if [ -n "$PS1" ] ; then                       # are we interactive?
   [ -r ~/.bashrc     ] && . ~/.bashrc        # tty/prompt/function setup for interactive shells.
   [ -r ~/.bash_login ] && . ~/.bash_login    # any at-login tasks for login shell only.
fi
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
