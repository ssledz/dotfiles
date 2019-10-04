#!/bin/bash

[[ -z $DBG ]] && DBG=0

black=\\e[31m
red=\\e[31m
blue=\\e[34m
green=\\e[32m
yellow=\\e[33m
magneta=\\e[35m
cyan=\\e[36m
white=\\e[97m
reset=\\e[0m

now() {
   date +"%Y-%m-%d %H:%M:%S"
}

eecho() {
    local label=$1
    shift
    local msg=
    if [[ $# == 0 ]]; then
        msg=$(cat -)
    else
        msg="$*"
    fi

    if [[ ! -z $current_color ]]; then
      msg="${!current_color}$msg${reset}"
      label="${!label_color}$label${reset}"
    fi

    echo -e "$label : "$msg
}

set_label_color() {
    label_color=$1
}

set_color() {
    current_color=$1
}

unset_color() {
    unset current_color
}

dbg() {
  [[ $DBG == 1 ]] && (1>&2 eecho "[DEBUG]" $*)
}

info() {
  eecho "$(now)" $*
}

warn() {
  eecho "[WARN]" $*
}

err() {
  (1>&2 eecho "[ERROR]" $*)
}
