### -*- mode: shell-script; coding: utf-8 -*- ###
### Fundamental Environmental Variables

export SHELL=/bin/zsh
export LANGUAGE="ja_JP.UTF-8"
export LC_MESSAGES="ja_JP.UTF-8"
export LANG="ja_JP.UTF-8"
export LC_CTYPE="ja_JP.UTF-8"
export LC_ALL="ja_JP.UTF-8"

# Binary Paths
typeset -U path PATH # Uniquify the PATH list

export PATH="/Users/hiromi/.deno/bin":$PATH
export PATH=/Applications/Isabelle2013-2.app/Isabelle/bin:$PATH
export PATH=~/sevpn:$PATH
export PATH=/usr/bin:$PATH
export PATH=$HOME/usr/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH=/usr/local/go/bin:$PATH
export PATH=~/.rbenv/bin:$PATH
export PATH=~/.rbenv/shims:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/texbin:$PATH
export PATH=/usr/local/Cellar/smlnj/110.72/libexec/bin:$PATH
export PATH=/usr/local/share/npm/bin:$PATH
export PATH=~/.cabal/bin:$PATH
export PATH=~/Library/Haskell/bin:$PATH
export PATH=/Applications/Emacs.app/Contents/MacOS/bin:$PATH
export PATH=~/usr/kahua/bin:$PATH
export PATH=/usr/X11/bin:$PATH
export PATH=~/usr/ghc-ios-scripts:$PATH
export PATH=~/node_modules/MathJax-node/bin/:$PATH
export PATH=/usr/local/mercury-14.01.1/bin:$PATH
export PATH=~/.local/bin:$PATH
export PATH="$CUDA_HOME/bin:$PATH"
export PATH="/usr/local/opt/lean@0.2/bin:$PATH"
export PATH="/snap/bin:$PATH"
export PATH="$HOME/.local/elmer/bin:$PATH"
if [ -d "/Applications/EasyWine64.app" ]; then
  export PATH="/Applications/EasyWine64.app/Contents/Resources/wine/bin:$PATH"
fi


# Library Paths
export DYLD_LIBRARY_PATH="$DYLD_LIBRARY_PATH:$CUDA_HOME/lib"
export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$CUDA_HOME/lib"
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH

if [ "$(hostname)" = "Jazz.local" -o "$(hostname)" = "Swing.local"  ]; then
  export EDITOR=code    
else
  export EDITOR=/usr/bin/emacs
  export ALTERNATE_EDITOR=/usr/bin/emacs
fi
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"
if [ -d $HOME/.nix-profile ]; then
  source $HOME/.nix-profile/etc/profile.d/nix.sh
  export LD_LIBRARY_PATH=$NIX_LINK/lib:$LD_LIBRARY_PATH
  export DYLD_LIBRARY_PATH=$NIX_LINK/lib:$DYLD_LIBRARY_PATH
  export PATH=$NIX_LINK/bin:$PATH
fi

if [ -d $HOME/.poetry/bin ]; then
  export PATH="$HOME/.poetry/bin:$PATH"
fi
