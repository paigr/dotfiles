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
export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
export LESS=" -R "

# Aliases
alias cat='bat -p'
alias cd='pushd'
alias cdtmp='cd $(mktemp -d)'
alias curlc='curl -s -o /dev/null -w "%{http_code}"'
alias diff='diff --suppress-common-lines -y'
alias df='df -h --exclude=tmpfs'
alias du='du -h'
alias feh='feh -.'
alias grep='grep --color=auto'
alias grip='grep -i'
alias la='ll -A'
alias ll='ls -lh'
alias lr='ls -r'
alias ls='ls -Sp --color=auto --group-directories-first'
alias mkdir='mkdir -pv'
alias mv='mv -iv'
alias pd='popd'
alias poweroff='sudo poweroff'
alias python='docker run --rm -it python:3.6 python'
alias reboot='sudo reboot'
alias scrot='DISPLAY=:0 scrot -s'
alias tree='tree --dirsfirst'
alias watch='watch -c -n1'
alias watchd='watch -d'
alias xclip='DISPLAY=:0 xclip -i -selection clipboard'
alias jq='jq -r'

alias ga='git add'
alias gb='git branch'
alias gc='git commit -v'
alias gco='git checkout'
alias gcou='git checkout $(git rev-parse --abbrev-ref HEAD@{upstream})'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log'
alias gp='git pull'
alias gs='git status'
alias gsl='git stash list'
alias gsp='git stash push'
alias gspo='git stash pop'
alias gss='git stash show'

mkcd() {
    mkdir -p $1 && cd $1
}

mkcrt() {
    openssl req -x509 \
        -out ca_cert.pem \
        -newkey rsa:4096 -keyout ca_key.pem \
        -days 365 \
        -subj '/CN=localhost' \
        -nodes \
    ;
    tmpdir=$(mktemp -d)
    cat <<EOF >> ${tmpdir}/csr.conf
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = DNS: ca-injector-example-server
EOF

    openssl req \
        -new -out server_csr.pem \
        -newkey rsa:2048 -keyout server_key.pem \
        -subj '/CN=example' \
        -nodes \
        -config ${tmpdir}/csr.conf \
    ;

    openssl x509 -req \
        -CA ca_cert.pem -CAkey ca_key.pem -CAcreateserial \
        -in server_csr.pem -out server_cert.pem \
        -days 365 \
        -extfile ${tmpdir}/csr.conf -extensions v3_req \
    ;

    rm -r ${tmpdir}
}


# Command prompt
if which fortune &>/dev/null; then echo -e "$L_GRAY$(fortune)"; echo; fi

#POWERLINE_BASH_CONTINUATION=1
#POWERLINE_BASH_SELECT=1
#source /usr/share/powerline/bindings/bash/powerline.sh

# Completions
source /usr/share/bash-completion/bash_completion
source <(plz --completion_script)
source <(kubectl completion bash)

# Attach to unattached session, or create new session
if [ -z $TMUX ]; then
    session=$(tmux ls -F '#{session_attached} #{session_id}' 2>/dev/null \
        | awk '{if ($1 == 0) {print $2}}' | head -1)

    if [ -n "$session" ]; then
        exec tmux a -t "$session"
    else
        exec tmux
    fi
fi

eval "$(starship init bash)"
