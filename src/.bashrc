# Run interactive only
[[ $- != *i* ]] && return

# Custom scripts
[[ -d ~/.bashrc.d ]] && for f in ~/.bashrc.d/*; do . $f; done

# Update window size
shopt -s checkwinsize

# Color sequences
BLACK="\e[0;30m"
RED="\e[0;31m"
GREEN="\e[0;32m"
YELLOW="\e[0;33m"
BLUE="\e[0;34m"
MAGENTA="\e[0;35m"
CYAN="\e[0;36m"
GRAY="\e[0;90m"
L_GRAY="\e[0;37m"
L_RED="\e[0;91m"
L_GREEN="\e[0;92m"
L_YELLOW="\e[0;93m"
L_BLUE="\e[0;94m"
L_MAGENTA="\e[0;95m"
L_CYAN="\e[0;96m"
WHITE="\e[0;97m"
RESET="\e[39m"

# Arch Linux blue
HOST="\x1b[38;2;19;120;170m"

# Environment variables
export VISUAL='vim'
export EDITOR='vim'
export PATH="$PATH:$HOME/bin"

# Aliases
alias ls='ls -Sp --color=auto --group-directories-first'
alias ll='ls -lh'
alias la='ll -A'
alias lr='ls -r'
alias cat='vimcat'
alias grep='grep --color=auto'
alias df='df -h | grep -v tmpfs'
alias du='du -h'
alias mkdir='mkdir -pv'
alias mv='mv -iv'
alias rm='mkdir -p /tmp/trash; mv -ft /tmp/trash'
alias feh='feh -.'
alias reboot='sudo reboot'
alias poweroff='sudo poweroff'
alias clip='xclip -i -selection clipboard'
alias watch='watch -n1'
alias python='docker run --rm -it python:3.6 python'

# Utility functions
mkcd() {
    mkdir $1; cd $1
}

roll() {
    if [ $# -eq 1 ]; then
        echo $(( ( RANDOM % $1 ) + 1 ))
    elif [ $# -eq 2 ]; then
        echo $(( ( RANDOM % $(( $2 - $1 + 1 )) ) + $1 ))
    else
        echo 'Usage: roll [MIN] MAX'
    fi
}

# Command prompt
if which fortune &>/dev/null; then echo -e "$L_GRAY$(fortune)"; echo; fi

POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
source /usr/share/powerline/bindings/bash/powerline.sh

# Attach to unattached session, or create new session
if [ -z $TMUX ]; then
    session=$(tmux ls -F '#{session_attached} #{session_id}' 2>/dev/null \
        | awk '{if ($1 == 0) {print $2}}' | head -1)

    [[ -n "$session" ]] && exec tmux a -t "$session" || exec tmux
fi
