
#Load all libs from load-lib dir
for my_lib ($ZSH_CUSTOM/plugins/ssledz-utils/load-lib/*); do
  source $my_lib
done

alias conv-cp1250-to-utf8='iconv -f cp1250 -t utf8'
alias print-machine-info='ssu_print_machine_info'
alias print-motherboard-mem-slots='sudo dmidecode --type memory' #print memory slots on motherboard

alias mount-cifs-ssledz='sudo mount -t cifs -o username=ssledz,iocharset=utf8,uid=ssledz'

alias ds-mount-download='mount-cifs-ssledz //ds/downloads'
alias ds-mount-download-mnt='ds-mount-download /mnt'
alias ds-mount-home='mount-cifs-ssledz //ds/homes/ssledz'
alias ds-mount-home-mnt='ds-mount-home /mnt'
