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

/usr/bin/xscreensaver -no-splash &
xsetroot -cursor_name left_ptr
#exec openbox-session
#feh --bg-scale ~/.wallpaper/archlinux-xmonad.jpg &
exec awesome
#exec xmonad

