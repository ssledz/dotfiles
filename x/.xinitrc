#!/usr/bin/env sh

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


# {{{ Display settings
case "$(hostname)" in
  xxxx)
    xrandr --output HDMI1 --auto --output HDMI2 --auto --right-of HDMI1
    ;;
  sigma)
    ;;
esac

# Ignore reported display size and force DPI
#xrandr --dpi 96
# }}}

# {{{ Autostart settings
#
urxvtd -q -f -o
dropbox start &
# }}}

exec awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
