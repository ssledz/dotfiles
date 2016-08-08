#!/usr/bin/env sh

# invoke global X session script
. /etc/X11/Xsession

# Setup locale
export LANG=pl_PL.utf8
export LC_MESSAGES=en_US.utf8


# Java incompatibility with awesome
export _JAVA_AWT_WM_NONREPARENTING=1

# Workaround a bug in XI focus-in events. See:
#  https://bugzilla.gnome.org/show_bug.cgi?id=677329
export GDK_CORE_DEVICE_EVENTS=1

case "$(hostname)" in
    xxxx)
        xrandr --output HDMI1 --auto --output HDMI2 --auto --right-of HDMI1
        ;;
    sigma)
        ;;
esac

exec awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
