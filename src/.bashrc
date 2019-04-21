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
alias cat='vimcat'
alias clip='xclip -i -selection clipboard'
alias df='df -h --exclude=tmpfs'
alias du='du -h'
alias feh='feh -.'
alias grep='grep --color=auto'
alias grepi='grep -i'
alias la='ll -A'
alias less='less --color=auto'
alias ll='ls -lh'
alias lr='ls -r'
alias ls='ls -Sp --color=auto --group-directories-first'
alias mkdir='mkdir -pv'
alias mv='mv -iv'
alias poweroff='sudo poweroff'
alias python='docker run --rm -it python:3.6 python'
alias reboot='sudo reboot'
alias rm='mkdir -p /tmp/trash; mv -ft /tmp/trash'
alias tar='tar -v'
alias tarc='tar -cf'
alias tart='tar -tf'
alias tarx='tar -xf'
alias watch='watch -c -n1'
alias watchd='watch -d'

mkcd() {
    mkdir -p $1 && cd $1
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
