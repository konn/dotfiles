### -*- mode: shell-script; coding: utf-8 -*- ###

# Simple command aliases
list=$(type -ap gsed)
if [ "$?" -eq 0 ]; then
    alias sed=gsed
else
    alias gsed=sed
fi
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
alias saty=satysfi
alias sl='sl -Fval'
alias sruby="/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby"
alias tjsim='rlwrap tjsim'
alias tmux-new='env tmux'
alias tmux='tmux attach'
alias vi=vim

# Jupyter alias for macOS
if [ "$(hostname)" = "Jazz.local" ]; then
    alias jupyter='stack exec jupyter --'
    alias jupyn='stack exec jupyter -- notebook'
fi


# Extension aliases
alias -s rb=ruby
alias -s hs=runhaskell
alias -s lhs=runhaskell


# Aliases defined by functions
autoload -Uz emacs
autoload -Uz teyjus
autoload -Uz less
autoload -Uz hoogle
