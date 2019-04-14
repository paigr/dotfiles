[[ ! $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx

[[ -f ~/.bashrc ]] && . ~/.bashrc
