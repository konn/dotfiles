### -*- mode: shell-script; coding: utf-8 -*- ###
### Prompt and navigation related configurations

autoload -U colors; colors

## Prompt Settings
if [[ $TERM != "dumb" ]]; then
  export ZLS_COLORS='di=01;34'

  setopt prompt_subst
  case "$(hostname)" in
      "sakura-vps")
          PROMPT=$'%{\e[38;5;100m%}%D{%a %m %d} %{\e[38;5;159m%}%n@sakura%{\e[38;5;015m%} %~\n%{\e[0m%}$ ' ;;
      "Ubuntu-VM")
          PROMPT=$'%{\e[38;5;100m%}%D{%a %m %d} %{\e[38;5;159m%}%n@ubuntu-vm %{\e[38;5;015m%} %~\n%{\e[0m%}$ ';;
      "Jazz.local" | "Swing.local")
          PROMPT=$'%{\e[34m%}%D{%a %m %d} %{\e[33m%}%n@%m%{\e[32m%} %~\n%{\e[0m%}$ ';;
      *)
          PROMPT=$'%{\e[34m%}%D{%a %m %d} %{\e[32m%}%n@%m%{\e[33m%} %~\n%{\e[0m%}$ ';;
  esac
  # Setting up right-hand side prompt for Git repos
  run_script git-prompt
  setopt TRANSIENT_RPROMPT
  precmd () {
      RPROMPT='$(__git_ps1 "git:(%s)")'
  }

  GIT_PS1_SHOWDIRTYSTATE=1
  GIT_PS1_SHOWSTASHSTATE=1
  GIT_PS1_SHOWUPSTREAM="auto"
  GIT_PS1_DESCRIBE_STYLE="branch"
  GIT_PS1_SHOWCOLORHINTS=1

  # Change background image for remote shell
  run_script remote-shell-change-bg
else
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    unfunction precmd
    unfunction preexec
fi

## Navigation Settings
setopt auto_pushd         # automatically pushd with cd
setopt auto_cd            # automatically try to cd when directory path entered
setopt PUSHD_IGNORE_DUPS

## History
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history
setopt hist_ignore_dups

## Tell the terminal about the working directory whenever it changes.
if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]] && [[ -z "$INSIDE_EMACS" ]]; then
    # Register the function so it is called whenever the working
    # directory changes.
    autoload -Uz update_terminal_cwd
    autoload add-zsh-hook
    add-zsh-hook chpwd update_terminal_cwd

    # Tell the terminal about the initial directory.
    update_terminal_cwd
fi
