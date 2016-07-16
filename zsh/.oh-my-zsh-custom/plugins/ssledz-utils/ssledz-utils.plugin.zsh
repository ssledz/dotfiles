
#Load all libs from load-lib dir
for my_lib ($ZSH_CUSTOM/plugins/ssledz-utils/load-lib/*); do
  source $my_lib
done

alias cp1250-to-utf8='iconv -f cp1250 -t utf8'
alias pmi='ssu_print_machine_info'

