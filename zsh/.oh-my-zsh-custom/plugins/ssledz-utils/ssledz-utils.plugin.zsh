
#Load all libs from load-lib dir
for my_lib ($ZSH_CUSTOM/plugins/ssledz-utils/load-lib/*); do
  source $my_lib
done

alias pargs='ps axo pid,args | grep'
alias pport='sudo netstat -tulpn | grep'
alias conv-cp1250-to-utf8='iconv -f cp1250 -t utf8'
alias print-machine-info='ssu_print_machine_info'
alias print-motherboard-mem-slots='sudo dmidecode --type memory' #print memory slots on motherboard

alias mount-cifs-ssledz='sudo mount -t cifs -o username=ssledz,iocharset=utf8,uid=ssledz'

alias ds-mount-download='mount-cifs-ssledz //ds/downloads'
alias ds-mount-download-mnt='ds-mount-download /mnt'
alias ds-mount-home='mount-cifs-ssledz //ds/homes/ssledz'
alias ds-mount-home-mnt='ds-mount-home /mnt'
alias ds-mount-video='mount-cifs-ssledz //ds/video'
alias ds-mount-video-mnt='ds-mount-video /mnt'


alias -g NULL="> /dev/null 2>&1"

alias sc-suspend='sudo systemctl suspend'

alias rand10='echo $(( ( RANDOM % 10 ) + 1 ))'
alias rand100='echo $(( ( RANDOM % 100 ) + 1 ))'
alias rand1000='echo $(( ( RANDOM % 1000 ) + 1 ))'

#Directory ailiasing
hash -d git=$HOME/git #~git
hash -d coursera=$HOME/git/coursera #~coursera
hash -d dot=$HOME/dotfiles

bindkey '^Q' push-line-or-edit
bindkey '^R' history-incremental-search-backward
