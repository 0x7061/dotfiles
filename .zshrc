# OMZ
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME=""

# Plugins
plugins=(
  git
  zsh-completions
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# Sync
source $ZSH/oh-my-zsh.sh

# Autosuggest
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="standout"
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE="20"
ZSH_AUTOSUGGEST_USE_ASYNC=1

# Editor
export EDITOR=nvim
export SUDO_EDITOR="$EDITOR"

# Shell config
export BAT_THEME=ansi
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
HISTSIZE=32768
SAVEHIST=$HISTSIZE
setopt APPEND_HISTORY HIST_IGNORE_DUPS HIST_IGNORE_SPACE

# File system
if command -v eza &>/dev/null; then
  alias ls='eza -lh --group-directories-first --icons=auto'
  alias lsa='ls -a'
  alias lt='eza --tree --level=2 --long --icons --git'
  alias lta='lt -a'
fi

alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias eff='$EDITOR "$(ff)"'

if command -v zoxide &>/dev/null; then
  eval "$(zoxide init zsh)"
  alias cd="zd"
  zd() {
    if (( $# == 0 )); then
      builtin cd ~ || return
    elif [[ -d $1 ]]; then
      builtin cd "$1" || return
    else
      if ! z "$@"; then
        echo "Error: Directory not found"
        return 1
      fi
      printf "\U000F17A9 "
      pwd
    fi
  }
fi

# Directories
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias cdr='cd $HOME/Work/Repositories'

# Tools
alias g='git'
alias gcm='git commit -m'
alias gcam='git commit -a -m'
alias gcad='git commit -a --amend'
alias d='docker'
alias t='tmux attach || tmux new -s Work'
alias vim=nvim
alias lzg='lazygit'
alias sclaude='nono run --profile claude --allow-cwd -- claude'
alias sopencode='nono run --profile opencode --allow-cwd -- opencode'

command -v mise &>/dev/null && eval "$(mise activate zsh)"
command -v fzf  &>/dev/null && source <(fzf --zsh)

# Starship
eval "$(starship init zsh)"

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk

# Flutter
export PATH=$HOME/Work/Flutter/flutter/sdk/bin:$PATH
export PATH=$PATH:$HOME/.pub-cache/bin

# Local bin
export PATH="$HOME/.local/bin:$PATH"
