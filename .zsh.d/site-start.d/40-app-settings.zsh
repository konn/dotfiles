### -*- mode: shell-script; coding: utf-8 -*- ###
### Environmental set-up for for other apps

# CUDA
export CUDA_HOME=/usr/local/cuda

# darcs
export DARCS_DONT_ESCAPE_ANYTHING=1
export DARCS_EDITOR="${HOME}/usr/bin/emacsclient"

# Editors
export EDITOR_KICKER="emacsclient -n +%s '%s'"

# less
export LESSCHARSET=utf-8
export LESS='-R'
export LESSOPEN='| src-hilite-lesspipe.sh %s' # syntax highlight 

# OPAM
. /Users/hiromi/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Ruby
eval "$(rbenv init -)"

# Rust
source $HOME/.cargo/env

# TeX, LaTeX and BibTeX
export BIBINPUTS=~/Library/texmf/bibtex/bib:${BIBUNPUTS}

# Travis gem
[ -f /Users/hiromi/.travis/travis.sh ] && source /Users/hiromi/.travis/travis.sh

# zed
autoload -U zed
