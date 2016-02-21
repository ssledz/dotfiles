# git
alias gst='git status' # Warning: gst conflicts with gnu-smalltalk (when used).
alias gb='git branch'
alias gco='git checkout'
alias gcob='git checkout -b '
alias ga='git add '
alias gc='git commit'
alias gg='git grep ' #  A great very FAST search option, easier then `find`
alias gi='cat ~/.git/cheat-sheet.txt'

alias ls='ls --color=auto'                                                                                                     
alias grep='grep --color=auto'                                                                                                 
alias fgrep='fgrep --color=auto'                                                                                               
alias egrep='egrep --color=auto'

# some more ls aliases                                                                                                             
alias ll='ls -alF'                                                                                                                 
alias la='ls -A'                                                                                                                   
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:                                                                    
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
