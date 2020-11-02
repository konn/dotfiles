### -*- mode: shell-script; coding: utf-8 -*- ###
export NIX_COMP_PATH="$ZSH_HOME/completions/nix"
source "$NIX_COMP_PATH/nix-zsh-completions.plugin.zsh"
FPATH=$NIX_COMP_PATH:$FPATH

# Completions provided by zsh
if [ -d /usr/local/share/zsh/site-functions ]; then
  FPATH=/usr/local/share/zsh/site-functions:$FPATH
fi

## Setting up completion units
autoload -U compinit && compinit
autoload -Uz locate_bin
zmodload zsh/complist

zstyle ':completion:*' completer _complete _match
zstyle ':completion:*' use-cache on
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Use bash-style completion as well.
autoload -U +X bashcompinit && bashcompinit

# Ignore cases and regard [-_.:] as surrounded by * and *.
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z} r:|[-_.:]=**'

# Use extended glob syntax of zsh
setopt extendedglob

## Completion settings for specific commands
# For Stack
locate_bin stack 1>/dev/null 2>/dev/null && eval "$(stack --bash-completion-script stack)"

# gh
locate_bin gh 1>/dev/null 2>/dev/null && eval "$(gh completion -s zsh)"

# Use ssh completion for mosh.
compdef mosh=ssh
