#!/bin/bash

DBG=0

dbg() {
  [[ $DBG == 1 ]] && (1>&2 echo "[DEBUG] : "$1)
}

info() {
  echo "[INFO] : $1"
}

warn() {
  echo "[WARN] : $1"
}

err() {
  (1>&2 echo "[ERROR] : $1")
}

show_help() {
  cat << EOF

  Usage: ${0##*/} -t title -m message -y timeout -s screen -b background -f foreground -n margin -w width [-d] [-h]

  Deploy adserver-active.

  -t tile                     Title.
  -m message
  -y timeout                  Timeout, exmaple 0
  -s screen                   Screen, example 2
  -b background               Background in format #535d9a
  -f foreground               Foreground in format #FFFFFF
  -n margin                   Maring, example 8
  -w width                    Width, example 302
  -d                          Dry run.
  -h                          Print this help.

EOF
}

dry_run=0
tile=
message=
timeout=0
screen=2
bg=#427142
fg=#FFFFFF
margin=8
width=302

while getopts "t:m:y:s:b:f:n:w:dh" opt; do

  case $opt in
    t)
      title=$OPTARG
      ;;
    m)
      message=$OPTARG
      ;;
    y)
      timeout=$OPTARG
      ;;
    s)
      screen=$OPTARG
      ;;
    b)
      bg=$OPTARG
      ;;
    f)
      fg=$OPTARG
      ;;
    n)
      margin=$OPTARG
      ;;
    w)
      width=$OPTARG
      ;;
    d)
      dry_run=1
      ;;
    h)
      show_help
      exit 0
      ;;
    \?)
      echo
      echo "   Invalid option: -$OPTARG" >&2
      show_help
      exit 1
      ;;
    *)
      echo
      show_help
      exit 2
      ;;
  esac

done


required=(title message)

for req in ${required[@]}; do
  [[ -z ${!req} ]] && echo && echo "  Please specify $req" && show_help &&  exit 1
done


[[ $dry_run -eq 1 ]] && info "Dry run"

msg="local naughty = require(\"naughty\"); naughty.notify({ \
  title = \"$title\",\
  text = \"$message\",\
  timeout = $timeout,\
  screen = $screen,\
  bg = \"$bg\",\
  fg = \"$fg\",\
  margin = $margin,\
  width = $width,\
  run = function (notification) notification.die() end })"

echo -e $msg | /usr/bin/awesome-client -
