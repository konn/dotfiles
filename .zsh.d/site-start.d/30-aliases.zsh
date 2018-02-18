### -*- mode: shell-script; coding: utf-8 -*- ###

# Aliases defined by functions
autoload -Uz emacs
autoload -Uz teyjus
autoload -Uz less

# Simple command aliases
alias cabal-install='cabal install'
alias cabal-reinstall='cabal install --reinstall'
alias caddy='ruby ~/prog/caddy/caddy.rb'
alias diff='colordiff'
alias egison='rlwrap egison'
alias favs='open -aSafari http://favstar.fm/users/mr_konn/recent'
alias gd='dirs -v; echo -n "select number: "; read newdir; cd +"$newdir"'

if [ -f "$(which hub)" ]; then
  alias git=hub
fi

alias gosh='rlwrap gosh'
alias io="rlwrap io"
alias irb="irb --simple-prompt"
alias jnethack='cocot -p EUC-JP jnethack'
alias ls='ls -vapa'
alias luajitlatex='luajittex --fmt=luajitlatex.fmt'
alias ocaml='rlwrap ocaml'
alias pip=pip3
alias python=python3
alias qemu='sudo /usr/local/bin/qemu'
alias sl='sl -Fval'
alias sruby="/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby"
alias tjsim='rlwrap tjsim'
alias tmux-new='env tmux'
alias tmux='tmux attach'
alias vi=vim

# Extension aliases
alias -s rb=ruby
alias -s hs=runhaskell
alias -s lhs=runhaskell
