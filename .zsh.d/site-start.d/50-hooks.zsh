### -*- mode: shell-script -*- ###
### Misc hook functions

# Check if any dotfile is updated (On local only)
autoload -Uz add-zsh-hook

case "$(hostname)" in
"Jazz.local" | "Swing.local")
    autoload -Uz check_dotfiles && check_dotfiles

    add-zsh-hook zshexit check_dotfiles
esac

which direnv >/dev/null && eval "$(direnv hook zsh)"
