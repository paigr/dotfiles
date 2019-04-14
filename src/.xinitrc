xset +fp /usr/share/fonts/noto &
xsetroot -bitmap ~/.wallpaper.xbm -fg '#1378aa' -bg '#1d1f21' &
xrdb -merge ~/.Xresources &
setxkbmap -option caps:escape &
xbindkeys &
powerline-daemon -q &

exec i3
