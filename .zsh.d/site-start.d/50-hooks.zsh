### -*- mode: shell-script -*- ###
### Misc hook functions

# Check if any dotfile is updated (On local only)
autoload -Uz add-zsh-hook

if [ $(hostname) = "Jazz.local" ]; then
    autoload -Uz check_dotfiles && check_dotfiles

    add-zsh-hook zshexit check_dotfiles
fi
