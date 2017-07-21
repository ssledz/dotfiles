#!/bin/bash


case "$1" in 
  button/mute) 
    ~/acpi/vol-m.sh
    ~/utils/aw-alert.sh -s 1 -t 'acpi' -m "$@" 
    ;;
  button/volumedown) ~/acpi/vol-d.sh ;;
  button/volumeup) ~/acpi/vol-u.sh ;;
  *) logger "ACPI action undefined: $@" ;;
esac
