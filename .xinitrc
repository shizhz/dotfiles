#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

if [ -f $HOME/.Xresources ]; then
    xrdb -merge $HOME/.Xresources
fi

export LANG=zh_CN.UTF-8
export LC_ALL="zh_CN.UTF-8"
gtk-query-immodules-2.0 > ~/.immodules
export GTK_IM_MODULE_FILE=~/.immodules
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
#export QT_IM_MODULE=ibus
export QT_IM_MODULE=xim
#ibus-daemon -drx >/dev/null
ibus-daemon -d --xim >/dev/null

exec i3
# exec awesome
