#!/usr/bin/env bash

# {{{ Environment settings
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Setup locale
export LANG=pl_PL.utf8
export LC_MESSAGES=en_US.utf8

# Java incompatibility with awesome
export _JAVA_AWT_WM_NONREPARENTING=1

# Workaround a bug in XI focus-in events. See:
#  https://bugzilla.gnome.org/show_bug.cgi?id=677329
export GDK_CORE_DEVICE_EVENTS=1
# }}}

# {{{ Resource and keymap settings
usermodmap="${HOME}/.Xmodmap"
userresources="${HOME}/.Xresources"
sysmodmap="/etc/X11/xinit/.Xmodmap"
sysresources="/etc/X11/xinit/.Xresources"

# Merge system and user resources and keymaps
[[ -r "${sysresources}" ]]  && xrdb -merge "${sysresources}"
[[ -r "${sysmodmap}" ]]     && xmodmap "${sysmodmap}"
[[ -r "${userresources}" ]] && xrdb -merge "${userresources}"
[[ -r "${usermodmap}" ]]    && xmodmap "${usermodmap}"
# }}}

# {{{ Input settings
#
# Keyboard control, repeat delay and repeat rate
xset r rate 200 30

# http://blog.ssokolow.com/archives/2011/12/24/getting-your-way-with-setxkbmap/
setxkbmap -option \
  -option compose:rctrl \
  -option lv3:ralt_switch \
  -option terminate:ctrl_alt_bkspc \
  -option eurosign:e \
  -option nbsp:level3n

# Pointer control, acceleration and threshold
xset m 30/10 4

# Pointer appearance
#   - xcb does not support Xcursor yet
xsetroot -cursor_name left_ptr

# Disable the touchpad while typing
syndaemon -k -i 2 -d &
# }}}

# {{{ Display settings
case "$(hostname)" in
  xxxx)
    xrandr --output HDMI1 --auto --output HDMI2 --auto --right-of HDMI1
    ;;
  sigma)
    xrandr --output eDP-1 --mode 1600x900 --primary
    ;;
esac

# Ignore reported display size and force DPI
#xrandr --dpi 96
# }}}

# {{{ Autostart settings
#
# }}}

case "$1" in 
  "awesome")
    urxvtd -q -f -o
    nm-applet --sm-disable &
    dropbox start &
    xscreensaver -no-splash &
    ~/acpi/acpi-listen.sh &
    exec awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
    ;;
  "i3")
    exec i3
    ;;
esac
