### -*- mode: shell-script -*- ###
### Misc hook functions

# Check if any dotfile is updated
autoload -Uz add-zsh-hook
autoload -Uz check_dotfiles && check_dotfiles

add-zsh-hook zshexit check_dotfiles
