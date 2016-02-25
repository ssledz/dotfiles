#!/bin/sh

# invoke global X session script
. /etc/X11/Xsession

exec awesome >> ~/.cache/awesome/stdout 2>> ~/.cache/awesome/stderr
