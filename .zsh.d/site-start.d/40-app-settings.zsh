### -*- mode: shell-script; coding: utf-8 -*- ###
### Environmental set-up for for other apps

# CUDA
export CUDA_HOME=/usr/local/cuda

# darcs
export DARCS_DONT_ESCAPE_ANYTHING=1
export DARCS_EDITOR="code --wait"

# Editors
export EDITOR_KICKER="code -g %s:%s"

# less
export LESSCHARSET=utf-8
export LESS='-R'
export LESSOPEN='| src-hilite-lesspipe.sh %s' # syntax highlight 
export HOMEBREW_NO_AUTO_UPDATE=1 
# OPAM
test -r /Users/hiromi/.opam/opam-init/init.zsh && . /Users/hiromi/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Ruby
locate_bin "rbenv" > /dev/null 2>&1 && eval "$(rbenv init -)"

# PyEnv and PipEnv
export PYENV_ROOT="$HOME/.pyenv"
export PIPENV_VENV_IN_PROJECT=true
export PATH="$PYENV_ROOT/bin:$PATH"
which  pyenv > /dev/null 2>&1  && eval "$(pyenv init -)"

# Rust
[ -d $HOME/.cargo/env ] && source $HOME/.cargo/env

# TeX, LaTeX and BibTeX
export BIBINPUTS=~/Library/texmf/bibtex/bib:${BIBUNPUTS}

# Travis gem
[ -f /Users/hiromi/.travis/travis.sh ] && source /Users/hiromi/.travis/travis.sh

# zed
autoload -U zed

# misc
autoload -Uz locate_bin

# SATySFi
export SATYSFI_LIB_ROOT=/usr/local/lib-satysfi
eval "$(rbenv init -)"
