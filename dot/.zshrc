# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
    git
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
)


# source $ZSH/oh-my-zsh.sh
eval "$(zoxide init zsh)"
# Check archlinux plugin commands here
# https://github.com/ohmyzshkohmyzsh/tree/master/plugins/archlinux

# Display Pokemon-colorscripts
# Project page: https://gitlab.com/phoneybadger/pokemon-colorscripts#on-other-distros-and-macos

# Set-up icons for files/folders in terminal
alias ls='eza --icons'
alias lsa='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'
alias cls="clear"
alias vim="nvim"
alias rebuild="$HOME/helper.sh"
alias cd="z"
alias cat="bat"

export MANPAGER='nvim +Man!'
export PATH="$HOME/.local/bin:$PATH"


# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)
# Define the function to change directory
open_dir() {
    local DIR
    DIR=$(find . -type d | fzf) # Use fzf to select a directory
    if [ -n "$DIR" ]; then
        cd "$DIR" || return
        echo "Changed directory to: $(pwd)"
    fi
}

# Bind Ctrl+N to the open_dir function
zle -N open_dir
bindkey '^N' open_dir

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

eval "$(starship init zsh)"
