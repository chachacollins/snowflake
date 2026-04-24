HISTSIZE=-1
HISTFILESIZE=-1
shopt -s histappend
shopt -s cmdhist
HISTCONTROL=ignoreboth
HISTTIMEFORMAT="%F %T "
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
shopt -s autocd
if [ "$EUID" -eq 0 ]; then
    PS1='\[\033[31m\][\[\033[1;33m\]root\[\033[32m\]@\[\033[1;34m\]\h\[\033[0m\] \w\[\033[31m\]]\[\033[0m\]\$ '
else
    PS1='\[\033[31m\][\[\033[1;33m\]\u\[\033[32m\]@\[\033[1;34m\]\h\[\033[0m\] \w\[\033[31m\]]\[\033[0m\]\$ '
fi
export PATH="$PATH:~/.local/bin"
bind '"\C-n": "tmux-sessionizer\C-m"'
alias grep="grep --color=auto"

